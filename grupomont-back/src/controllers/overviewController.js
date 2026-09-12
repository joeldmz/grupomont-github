import { dbquery } from '../config/database.js';

export const getOportunidadePipeline = async(req, res, next) => {
    try {
        const {status, start_date, end_date } = req.query;
        let query = `
            SELECT
                COUNT(*) AS total_oportunidades,
                COUNT(*) FILTER (
                    WHERE LOWER(o.status) = 'ganha'
                ) AS oportunidades_ganhas,
                COUNT(*) FILTER (
                    WHERE LOWER(o.status) = 'aberta'
                ) AS oportunidades_abertas,
                COUNT(*) FILTER (
                    WHERE LOWER(o.status) = 'perdida'
                ) AS oportunidades_perdidas,
                ROUND(
                    AVG(o.probabilidade) FILTER (
                        WHERE LOWER(o.status) = 'aberta'
                    ),
                    2
                ) AS probabilidade_media_abertas,
                COALESCE(
                    SUM(
                        COALESCE(o.valor_estimado, 0)
                    ) FILTER (
                        WHERE LOWER(o.status) = 'aberta'
                    ),
                    0
                ) AS valor_potencial,
                 COALESCE(
                    SUM(
                        COALESCE(o.valor_estimado, 0)
                    ) FILTER (
                        WHERE LOWER(o.status) = 'ganha'
                    ),
                    0
                ) AS valor_realizado,
                 COALESCE(
                    SUM(
                        COALESCE(o.valor_estimado, 0)
                    ) FILTER (
                        WHERE LOWER(o.status) = 'perdida'
                    ),
                    0
                ) AS valor_perdido,
                COALESCE(
                    SUM(
                        COALESCE(o.valor_estimado, 0)
                        * COALESCE(o.probabilidade, 0) / 100
                    ) FILTER (
                        WHERE LOWER(o.status) = 'aberta'
                    ),
                    0
                ) AS valor_ponderado_abertas
            FROM oportunidade o
            JOIN campanha c
                ON c.id = o.campanha_id
            WHERE
                ($1::varchar IS NULL OR LOWER(c.status) = LOWER($1::varchar))
                AND ($2::date IS NULL OR o.data_criacao >= $2::date)
                AND ($3::date IS NULL OR o.data_criacao < $3::date);
        `
        const dbresponse = await dbquery(query, [status, start_date, end_date]);
        res.json(dbresponse.rows.length > 0 ? dbresponse.rows[0] : {});
    } catch (error) {
        next(error);
    }
}

export const getMarketingPerformance = async(req, res, next) => {
    try {
        const { start_date, end_date } = req.query;
        let query = `
        WITH leads AS (
            SELECT
                l.unidade_negocio_id,
                COUNT(*) AS total_leads
            FROM public.lead l
            WHERE (
                $1::date IS NULL
                OR l.data_entrada >= $1::date
            )
            AND (
                $2::date IS NULL
                OR l.data_entrada < $2::date
            )
            GROUP BY l.unidade_negocio_id
        ),
        oportunidades AS (
            SELECT
                o.unidade_negocio_id,
                COUNT(*) AS total_oportunidades
            FROM public.oportunidade o
            WHERE (
                $1::date IS NULL
                OR o.data_criacao >= $1::date
            )
            AND (
                $2::date IS NULL
                OR o.data_criacao < $2::date
            )
            GROUP BY o.unidade_negocio_id
        ),
        metas AS (
            SELECT
                m.unidade_negocio_id,

                SUM(
                    CASE
                        WHEN m.tipo_meta = 'Leads'
                        THEN m.valor_meta
                        ELSE 0
                    END
                ) AS meta_leads,

                SUM(
                    CASE
                        WHEN m.tipo_meta = 'Oportunidades'
                        THEN m.valor_meta
                        ELSE 0
                    END
                ) AS meta_oportunidades
            FROM public.meta m
            WHERE (
                $1::date IS NULL
                OR m.periodo_inicio >= $1::date
            )
            AND (
                $2::date IS NULL
                OR m.periodo_inicio < $2::date
            )
            GROUP BY m.unidade_negocio_id
        )
        SELECT
            un.id,
            un.nome AS unidade_negocio,
            COALESCE(l.total_leads, 0) AS leads_realizados,
            COALESCE(m.meta_leads, 0) AS meta_leads,
            COALESCE(o.total_oportunidades, 0) AS oportunidades_realizadas,
            COALESCE(m.meta_oportunidades, 0) AS meta_oportunidades,
            ROUND(
                COALESCE(o.total_oportunidades, 0) * 100.0 /
                NULLIF(l.total_leads, 0),
                1
            ) AS taxa_conversao
        FROM public.unidade_negocio un
        LEFT JOIN leads l
            ON l.unidade_negocio_id = un.id
        LEFT JOIN oportunidades o
            ON o.unidade_negocio_id = un.id
        LEFT JOIN metas m
            ON m.unidade_negocio_id = un.id
        ORDER BY un.nome;
        `
        const dbresponse = await dbquery(query, [start_date, end_date])
        res.json(dbresponse.rows)
    } catch (error) {
        next(error);
    }
}