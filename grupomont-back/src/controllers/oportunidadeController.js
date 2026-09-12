import { dbquery } from '../config/database.js';

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
        next(error);
    }
}

export const getPipelineByUnidade = async(req, res, next) => {
    try {
        const { start_date, end_date } = req.query
        let query = `
        SELECT
            un.id AS unidade_negocio_id,
            un.nome AS unidade_negocio,
            COUNT(o.id) AS quantidade_oportunidades,
            COALESCE(SUM(o.valor_estimado), 0) AS pipeline,
            COALESCE(
                SUM(
                    o.valor_estimado *
                    COALESCE(o.probabilidade, 0) / 100
                ),
                0
            ) AS pipeline_ponderado,
            CASE
                WHEN SUM(o.valor_estimado) > 0
                THEN
                    SUM(
                        o.valor_estimado *
                        COALESCE(o.probabilidade, 0) / 100
                    )
                    / SUM(o.valor_estimado) * 100
                ELSE 0
            END AS probabilidade_geral
        FROM public.unidade_negocio un
        LEFT JOIN public.oportunidade o
            ON o.unidade_negocio_id = un.id
            AND o.status NOT IN ('Ganha', 'Perdida')
            AND ($1::date IS NULL OR o.data_criacao >= $1::date)
            AND ($2::date IS NULL OR o.data_criacao < $2::date)
        WHERE un.id IN (1, 2, 3)
        GROUP BY
            un.id,
            un.nome
        ORDER BY
            un.id;
        `
        const dbresponse = await dbquery(query, [start_date, end_date])
        res.json(dbresponse.rows)
    } catch (error) {
        next(error);
    }
}

export const getOportunidadeByEquipe = async(req, res, next) => {
    try {
        const { start_date, end_date } = req.query
        let query = `
        WITH oportunidades AS (
            SELECT
                e.id AS equipe_id,
                e.nome AS equipe,

                COUNT(o.id) AS oportunidades,

                COUNT(o.id) FILTER (
                    WHERE LOWER(o.status) = 'ganha'
                ) AS oportunidades_ganhas,

                COALESCE(
                    SUM(o.valor_estimado) FILTER (
                        WHERE LOWER(o.status) = 'aberta'
                    ),
                    0
                ) AS pipeline

            FROM equipe e

            LEFT JOIN consultor c
                ON c.equipe_id = e.id

            LEFT JOIN oportunidade o
                ON o.consultor_id = c.id
                AND ($1::date IS NULL OR o.data_criacao >= $1::date)
                AND ($2::date IS NULL OR o.data_criacao < $2::date)

            GROUP BY
                e.id,
                e.nome
        ),

        receitas AS (
            SELECT
                c.equipe_id,
                COALESCE(SUM(r.valor), 0) AS valor_realizado

            FROM receita r

            JOIN oportunidade o
                ON o.id = r.oportunidade_id

            JOIN consultor c
                ON c.id = o.consultor_id

            WHERE
                r.status = 'Realizada'
                AND ($1::date IS NULL OR r.data >= $1::date)
                AND ($2::date IS NULL OR r.data < $2::date)

            GROUP BY
                c.equipe_id
        )

        SELECT
            o.equipe_id,
            o.equipe,
            o.oportunidades,
            o.oportunidades_ganhas,

            ROUND(
                o.oportunidades_ganhas::numeric
                / NULLIF(o.oportunidades, 0) * 100,
                2
            ) AS conversao,

            o.pipeline,

            COALESCE(r.valor_realizado, 0) AS valor_realizado

        FROM oportunidades o

        LEFT JOIN receitas r
            ON r.equipe_id = o.equipe_id

        ORDER BY
            valor_realizado DESC;
        `
        const dbresponse = await dbquery(query, [start_date, end_date])
        res.json(dbresponse.rows)
    } catch (error) {
        next(error);
    }
}