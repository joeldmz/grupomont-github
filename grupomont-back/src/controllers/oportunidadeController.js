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