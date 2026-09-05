import { dbquery } from '../config/database.js';

export const getLeads = async(req, res, next) => {
    try {
        const resutl = await dbquery('SELECT * FROM lead;');
        res.json(resutl.rows);
    } catch (error) {
        next(error)
    }
}

export const getTotalLeadsB = async(req, res, next) => {
    try {
        const { status, start_date, end_date, campanha_id } = req.query;
        let params = [];
        let conditions = [];
        let query = `SELECT COUNT(*) as total FROM lead`

        if(status) {
            params.push(status);
            conditions.push(`status = $${params.length}`)
        }

        if(start_date && end_date) {
            params.push(start_date);
            conditions.push(`data_entrada >= $${params.length}`);

            params.push(end_date);
            conditions.push(`data_entrada <= $${params.length}`)
        }
        
        if(campanha_id) {
            params.push(campanha_id);
            conditions.push(`campanha_id = $${params.length}`)
        }

        if(conditions.length > 0) {
            query += ' WHERE ' + conditions.join(' AND ');
        }


        const resutl = await dbquery(query, params);
        res.json(resutl.rows);
    } catch (error) {
        next(error)
    }
}

export const getTotalLead = async(req, res, next) => {
    try {
        const { status, start_date, end_date, campanha_id } = req.query;
        let query = `
        WITH leads_periodo AS (
            SELECT
                COUNT(*) AS value
            FROM public.lead l
            WHERE (
                $1::date IS NULL
                OR l.data_entrada >= $1::date
            )
            AND (
                $2::date IS NULL
                OR l.data_entrada < $2::date
            )
        ),

        meta_leads AS (
            SELECT
                COALESCE(SUM(m.valor_meta), 0) AS target
            FROM public.meta m
            WHERE m.tipo_meta = 'Leads'
        )

        SELECT
            l.value,
            m.target,

            l.value - m.target AS gap,

            ROUND(
                l.value * 100.0 /
                NULLIF(m.target, 0),
                1
            ) AS percentual_meta

        FROM leads_periodo l
        CROSS JOIN meta_leads m;
        `
        const dbresult = await dbquery(query, [start_date, end_date]);
        res.json(dbresult.rows.length > 0 ? dbresult.rows[0] : {});
    } catch (error) {
        next(error)
    }
} 

export const getLeadByUnidade = async(req, res, next) => {
    try {
        let query = `
        WITH metas_leads AS (
            SELECT
                unidade_negocio_id,
                SUM(valor_meta) AS meta_leads
            FROM meta
            WHERE LOWER(tipo_meta) = 'leads'
            GROUP BY unidade_negocio_id
        ),

        leads_realizados AS (
            SELECT
                c.unidade_negocio_id,
                COUNT(l.id) AS total_leads
            FROM campanha c
            LEFT JOIN lead l
                ON l.campanha_id = c.id
            WHERE c.status = 'Ativa'
            GROUP BY c.unidade_negocio_id
        )

        SELECT
            un.id AS unidade_negocio_id,
            un.nome AS title,
            COALESCE(m.meta_leads, 0) AS target,
            COALESCE(l.total_leads, 0) AS value
        FROM unidade_negocio un
        LEFT JOIN metas_leads m
            ON m.unidade_negocio_id = un.id
        LEFT JOIN leads_realizados l
            ON l.unidade_negocio_id = un.id
        ORDER BY un.nome;
        `
        const dbresult = await dbquery(query);
        res.json(dbresult.rows);
    } catch (error) {
        next(error)
    }
} 

export const getLeadByCampanha = async(req, res, next) => {
    try {
        let query = `
            select
                c.id,
                c.nome,
                COUNT(l.id) as total
            from campanha c
            left join lead l on l.campanha_id = c.id
            group by c.id, c.nome
            order by total desc;
        `
        const result = await dbquery(query);
        res.json(result.rows);
    } catch (error) {
        next(error)
    }
}

/*SELECT
    (SELECT COUNT(*)
     FROM lead
     WHERE data_entrada >= '2026-08-01'
       AND data_entrada < '2026-09-01') AS volume_leads,

    (SELECT COUNT(*)
     FROM oportunidade
     WHERE data_criacao >= '2026-08-01'
       AND data_criacao < '2026-09-01') AS volume_oportunidades;*/