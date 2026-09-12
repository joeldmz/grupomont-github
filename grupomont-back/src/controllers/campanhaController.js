import { dbquery } from '../config/database.js';

export const getTotalCampanhas = async(req, res, next) => {
    try {
        const { start_date, end_date, status } = req.query;
        let query = `
        WITH campanhas AS (
            SELECT
                c.id,
                c.unidade_negocio_id,
                COALESCE(c.investimento, 0) AS investimento
            FROM public.campanha c
            WHERE c.unidade_negocio_id IS NOT NULL
            AND ($1::date IS NULL OR c.data_inicio >= $1::date)
            AND ($2::date IS NULL OR c.data_inicio < $2::date)
            AND ($3::varchar IS NULL OR c.status = $3::varchar)
        ),
        comercial AS (
            SELECT
                o.campanha_id,
                COUNT(DISTINCT o.lead_id) AS leads,
                COUNT(DISTINCT o.id) AS oportunidades,
                COUNT(DISTINCT o.id) FILTER (
                    WHERE o.status = 'Ganha'
                ) AS oportunidades_ganhas,
                COALESCE(SUM(o.valor_estimado), 0) AS valor_pipeline,
                COALESCE(
                    SUM(
                        o.valor_estimado * COALESCE(o.probabilidade, 0) / 100
                    ),
                    0
                ) AS valor_ponderado
            FROM public.oportunidade o
            WHERE o.campanha_id IS NOT NULL
            GROUP BY o.campanha_id
        ),
        receitas AS (
            SELECT
                o.campanha_id,
                COALESCE(SUM(r.valor), 0) AS receita_realizada
            FROM public.receita r
            INNER JOIN public.oportunidade o
                ON o.id = r.oportunidade_id
            WHERE o.campanha_id IS NOT NULL
            AND r.status = 'Realizada'
            GROUP BY o.campanha_id
        )
        SELECT
            un.id AS unidade_negocio_id,
            un.nome AS unidade_negocio,
            COALESCE(SUM(c.investimento), 0) AS investimento,
            COALESCE(SUM(com.leads), 0) AS leads,
            COALESCE(SUM(com.oportunidades), 0) AS oportunidades,
            COALESCE(SUM(com.valor_pipeline), 0) AS valor_pipeline,
            COALESCE(SUM(com.valor_ponderado), 0) AS valor_ponderado,
            COALESCE(SUM(com.oportunidades_ganhas), 0) AS oportunidades_ganhas,
            COALESCE(SUM(r.receita_realizada), 0) AS receita_realizada
        FROM public.unidade_negocio un
        LEFT JOIN campanhas c
            ON c.unidade_negocio_id = un.id
        LEFT JOIN comercial com
            ON com.campanha_id = c.id
        LEFT JOIN receitas r
            ON r.campanha_id = c.id
        WHERE un.id IN (1, 2, 3)
        GROUP BY
            un.id,
            un.nome
        ORDER BY un.id;
        `
        const dbresult = await dbquery(query, [start_date, end_date, status]);
        res.json(dbresult.rows);
    } catch (error) {
        next(error)
    }
}



export const getCampanha = async(req, res, next) => {
    try {
        const { 
            unidade_id,
            canal_id, 
            status,
            start_date,
            end_date
        } = req.query;

        let params = [];
        let conditions = [];

        let query = `
            SELECT
                c.id,
                c.nome,
                c.data_inicio,
                c.data_fim,
                c.investimento,
                c.status,
                c.unidade_negocio_id,
                u.nome AS unidade_negocio,
                (
                    SELECT STRING_AGG(canal.nome, ', ' ORDER BY canal.nome)
                    FROM public.campanha_canal cc
                    JOIN public.canal canal
                        ON canal.id = cc.canal_id
                    WHERE cc.campanha_id = c.id
                ) AS canais
            FROM public.campanha c
            LEFT JOIN public.unidade_negocio u
                    ON u.id = c.unidade_negocio_id
            WHERE (
                $1::date IS NULL
                OR c.data_inicio >= $1::date
            )
            AND (
                $2::date IS NULL
                OR c.data_inicio < $2::date
            )
            ORDER BY c.data_inicio DESC
            LIMIT 5;
        `
        const dbresult = await dbquery(query, [start_date, end_date]);
        res.json(dbresult.rows);
    } catch (error) {
        next(error)
    }
}

export const getCampanhaById = async(req, res, next) => {
    try {
        const { 
            id,
            start_date,
            end_date
        } = req.query;

        let query = `
        SELECT
            c.id,
            c.nome,
            c.data_inicio,
            c.data_fim,
            c.investimento,
            c.status,

            u.nome AS unidade_negocio,

            (
                SELECT STRING_AGG(canal.nome, ', ' ORDER BY canal.nome)
                FROM public.campanha_canal cc
                JOIN public.canal canal
                    ON canal.id = cc.canal_id
                WHERE cc.campanha_id = c.id
            ) AS canais,
            (
                SELECT COUNT(*)
                FROM public.lead l
                WHERE l.campanha_id = c.id
            ) AS leads,
            (
                SELECT COUNT(*)
                FROM public.oportunidade o
                WHERE o.campanha_id = c.id
            ) AS oportunidades,
            (
                SELECT COALESCE(SUM(m.valor_meta), 0)
                FROM public.meta m
                WHERE m.campanha_id = c.id
                AND m.tipo_meta = 'Leads'
            ) AS meta_leads,
            (
                SELECT COALESCE(SUM(m.valor_meta), 0)
                FROM public.meta m
                WHERE m.campanha_id = c.id
                AND m.tipo_meta = 'Oportunidades'
            ) AS meta_oportunidades

        FROM public.campanha c

        LEFT JOIN public.unidade_negocio u
            ON u.id = c.unidade_negocio_id

        WHERE (
            $2::date IS NULL
            OR c.data_inicio >= $2::date
        )
        AND (
            $3::date IS NULL
            OR c.data_inicio < $3::date
        )

        AND c.id = $1

        ORDER BY c.data_inicio DESC
        LIMIT 5;
        `
        const dbresult = await dbquery(query, [id, start_date, end_date]);
        res.json(dbresult.rows);
    } catch (error) {
        next(error)
    }
}



export const getInvestimento = async(req, res, next) => {
    try {
        const { 
            unidade_id,
            canal_id, 
            status,
            start_date,
            end_date
        } = req.query;

        let params = [];
        let conditions = [];

        let query = `
            SELECT
                COALESCE(SUM(c.investimento), 0) AS investimento_consolidado
            FROM public.campanha c
        `
        
        if(unidade_id) {
            params.push(unidade_id);
            conditions.push(`unidade_negocio_id = $${params.length}`)
        }

        if(start_date && end_date) {
            params.push(start_date);
            conditions.push(`data_inicio >= $${params.length}`);

            params.push(end_date);
            conditions.push(`data_inicio <= $${params.length}`);
        }

        if(conditions.length > 0) {
            query += ' where ' + conditions.join(' and ');
        }

        const result = await dbquery(query, params);
        res.json(result.rows.length ? result.rows[0] : {});
    } catch (error) {
        next(error)
    }
}

export const getResultadoByCanal = async(req, res, next) => {
    try {
        const { start_date, end_date } = req.query;

        let query = `
            
        SELECT
            c.id,
            c.nome AS canal,
            COUNT(DISTINCT l.id) AS leads,
            COUNT(DISTINCT CASE
                WHEN l.status = 'Convertido' THEN l.id
            END) AS oportunidades
        FROM public.canal c
        LEFT JOIN public.lead l
            ON l.canal_id = c.id
        WHERE
            ($1::date IS NULL OR l.data_entrada >= $1::date)
            AND
            ($2::date IS NULL OR l.data_entrada < $2::date)
        GROUP BY
            c.id,
            c.nome
        HAVING COUNT(DISTINCT l.id) > 0
        ORDER BY leads DESC;
        `

        const dbresponse = await dbquery(query, [start_date, end_date])
        res.json(dbresponse.rows)

    } catch (error) {
        next(error)
    }
}