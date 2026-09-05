import { dbquery } from '../config/database.js';

export const getOportunidade = async(req, res, next) => {
    try { 
        const { 
            negocio_id,
            empresa_id, 
            psaude_id , 
            start_date, 
            end_date, 
            status
        } = req.query;

        let query = `
            select
                c.id,
                c.razao_social as cliente,
                ps.nome as plano_saude,
                ef.nome as Etapa,
                o.status as Estagio,
                o.probabilidade as probabilidade_fechamento,
                o.valor_estimado
            from oportunidade o
            left join cliente c on o.cliente_id = c.id
            left join etapa_funil ef on o.etapa_id = ef.id
            left join plano_saude ps on o.plano_id = ps.id
        `
        let conditions = [];
        let params =[];

        if(negocio_id) {
            params.push(negocio_id)
            conditions.push(`o.unidade_negocio_id = $${params.length}`);
        }

        if(empresa_id) {
            params.push(empresa_id);
            conditions.push(`e.id = $${params.length}`);
        }

        if(psaude_id) {
            params.push(psaude_id);
            conditions.push(`ps.id = $${params.length}`);
        }

        if(status) {
            params.push(status);
            conditions.push(`o.status = $${params.length}`)
        }

        if(start_date && end_date) {
            params.push(start_date);
            conditions.push(`data_criacao >= $${params.length}`);

            params.push(end_date);
            conditions.push(`data_criacao <= $${params.length}`)
        }

        if(conditions.length > 0) {
            query += ' where ' + conditions.join(' and ');
        }

        let dbresponse = await dbquery(query, params);
        res.json(dbresponse.rows)

    } catch (error) {
        next(error)
    }
}


export const getTolalOportunidade = async(req, res, next) => {
    try {
        let query = `
        select
            un.nome as unidade_negocio,
            COUNT(o.id) as total_oportunidades
        from public.oportunidade o
        join public.unidade_negocio un
            ON un.id = o.unidade_negocio_id
        group by un.nome
        order by total_oportunidades DESC;
        `
        const dbresponse = await dbquery(query)
        res.json(dbresponse.rows)
    } catch (error) {
        next(error)
    }
}


export const getTotalOportunidade = async(req, res, next) => {
    try {
        const { status, start_date, end_date, campanha_id } = req.query;
        let query = `
        WITH oportunidades_periodo AS (
            SELECT
                COUNT(*) AS value
            FROM public.oportunidade o
            WHERE (
                $1::date IS NULL
                OR o.data_criacao >= $1::date
            )
            AND (
                $2::date IS NULL
                OR o.data_criacao < $2::date
            )
        ),

        meta_oportunidades AS (
            SELECT
                COALESCE(SUM(m.valor_meta), 0) AS target
            FROM public.meta m
            WHERE m.tipo_meta = 'Oportunidades'
            AND (
                $1::date IS NULL
                OR m.periodo_inicio >= $1::date
            )
            AND (
                $2::date IS NULL
                OR m.periodo_inicio < $2::date
            )
        )

        SELECT
            o.value,
            m.target,

            o.value- m.target AS gap,

            ROUND(
                o.value * 100.0 /
                NULLIF(m.target, 0),
                1
            ) AS percentual_meta

        FROM oportunidades_periodo o
        CROSS JOIN meta_oportunidades m;
        `
        const dbresponse = await dbquery(query, [start_date, end_date])
        res.json(dbresponse.rows.length > 0 ? dbresponse.rows[0] : {})
    } catch (error) {
        next(error)
    }
}


export const getOportunidadeByUnidade = async(req, res, next) => {
    try {
        let query = `
        WITH metas_oportunidades AS (
            SELECT
                unidade_negocio_id,
                SUM(valor_meta) AS meta_oportunidades
            FROM meta
            WHERE LOWER(tipo_meta) = 'oportunidades'
            GROUP BY unidade_negocio_id
        ),

        oportunidades_realizadas AS (
            SELECT
                c.unidade_negocio_id,
                COUNT(o.id) AS total_oportunidades
            FROM campanha c
            LEFT JOIN oportunidade o
                ON o.campanha_id = c.id
            WHERE c.status = 'Ativa'
            GROUP BY c.unidade_negocio_id
        )

        SELECT
            un.id AS unidade_negocio_id,
            un.nome AS title,
            COALESCE(m.meta_oportunidades, 0) AS target,
            COALESCE(o.total_oportunidades, 0) AS value
        FROM unidade_negocio un
        LEFT JOIN metas_oportunidades m
            ON m.unidade_negocio_id = un.id
        LEFT JOIN oportunidades_realizadas o
            ON o.unidade_negocio_id = un.id
        ORDER BY un.nome;
        `
        const dbresponse = await dbquery(query)
        res.json(dbresponse.rows)
    } catch (error) {
        next(error)
    }
}
