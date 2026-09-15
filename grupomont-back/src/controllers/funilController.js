import { dbquery } from '../config/database.js';

export const getOportunidadeByEtapa = async(req, res, next) => {
    try {
        const { funil_id } = req.query;
        let query = `
            select
                ef.nome as etapa,
                COUNT(o.id) as quantidade
            from etapa_funil ef
            left join oportunidade o 
                on o.etapa_id = ef.id
            
        `
        if(funil_id) {
            query += ` where funil_id = ${funil_id} `
        }

        query += `group by ef.id, ef.nome, ef.ordem order by ef.ordem;`

        const dbresponse = await dbquery(query);
        res.json(dbresponse.rows);
    } catch (error) {
        next(error)
    }
}

export const getHistoricoEtapa = async(req, res, next) => {
    try {
        let query = `
            select
                ef.nome as etapa,
                count(DISTINCT h.oportunidade_id) as quantidade
            from etapa_funil ef
            left join historico_oportunidade h
                on h.etapa_id = ef.id
            group by ef.id, ef.nome, ef.ordem
            order by ef.ordem;
        `
        const dbresponse = await dbquery(query);
        res.json(dbresponse.rows);
    } catch (error) {
        next(error);
    }
}

export const getFunilConsolidado = async(req, res, next) => {
    try {
        const {status, start_date, end_date} = req.query;
        let query = `
            WITH etapas_base AS (
                SELECT * FROM (
                    VALUES
                        ('Qualificação', 1),
                        ('Diagnóstico', 2),
                        ('Proposta', 3),
                        ('Negociação', 4),
                        ('Fechamento', 5)
                ) AS e(etapa, ordem)
            ),

            dados AS (
                SELECT
                    vf.etapa_consolidada AS etapa,
                    vf.ordem_consolidada AS ordem,

                    COUNT(*) AS total,

                    COALESCE(SUM(vf.valor_estimado), 0) AS valor_pipeline,

                    ROUND(
                        AVG(o.probabilidade),
                        1
                    ) AS probabilidade_media,

                    ROUND(
                        COALESCE(
                            SUM(
                                vf.valor_estimado *
                                COALESCE(o.probabilidade, 0) / 100
                            ),
                            0
                        ),
                        2
                    ) AS valor_ponderado

                FROM public.vw_funil_consolidado vf

                INNER JOIN public.oportunidade o
                    ON o.id = vf.oportunidade_id

                INNER JOIN public.campanha c
                    ON c.id = o.campanha_id

                WHERE 
                (
                    $1::text[] IS NULL
                    OR o.status = ANY($1::text[])
                )
                AND (
                    $2::date IS NULL
                    OR o.data_criacao >= $2::date
                )
                AND (
                    $3::date IS NULL
                    OR o.data_criacao <= $3::date
                )
                GROUP BY
                    vf.etapa_consolidada,
                    vf.ordem_consolidada
            )

            SELECT
                eb.etapa,
                eb.ordem,

                COALESCE(d.total, 0) AS total,

                ROUND(
                    COALESCE(d.total, 0) * 100.0 /
                    NULLIF(
                        SUM(COALESCE(d.total, 0)) OVER (),
                        0
                    ),
                    1
                ) AS percentual,

                COALESCE(d.valor_pipeline, 0) AS valor_pipeline,

                COALESCE(d.probabilidade_media, 0) AS probabilidade_media,

                COALESCE(d.valor_ponderado, 0) AS valor_ponderado

            FROM etapas_base eb

            LEFT JOIN dados d
                ON d.ordem = eb.ordem

            ORDER BY eb.ordem;
        `
        const dbresponse = await dbquery(query, [status?.length ? status : null, start_date, end_date]);
        res.json(dbresponse.rows);
    } catch (error) {
        next(error);
    }
}

export const getHistoricoFunilConsolidado = async(req, res, next) => {
    try {
        const {status, start_date, end_date} = req.query;
        let query = `
        WITH etapas_base AS (
            SELECT * FROM (
                VALUES
                    ('Qualificação', 1),
                    ('Diagnóstico', 2),
                    ('Proposta', 3),
                    ('Negociação', 4),
                    ('Fechamento', 5)
            ) AS e(etapa, ordem)
        ),

        etapas AS (
            SELECT
                vh.etapa_consolidada AS etapa,
                vh.ordem_consolidada AS ordem,

                COUNT(DISTINCT vh.oportunidade_id) AS total_oportunidades,

                ROUND(
                    AVG(
                        EXTRACT(
                            EPOCH FROM (
                                COALESCE(
                                    vh.data_saida,
                                    NOW()::timestamp
                                ) - vh.data_entrada
                            )
                        ) / 86400
                    )::numeric,
                    1
                ) AS media_dias

            FROM public.vw_funil_historico vh

            INNER JOIN public.oportunidade o
                ON o.id = vh.oportunidade_id

            INNER JOIN public.campanha c
                ON c.id = o.campanha_id

            WHERE
            (
                    $1::text[] IS NULL
                    OR o.status = ANY($1::text[])
            )
            AND (
                    $2::date IS NULL
                    OR o.data_criacao >= $2::date
                )
                AND (
                    $3::date IS NULL
                    OR o.data_criacao <= $3::date
                )
            GROUP BY
                vh.etapa_consolidada,
                vh.ordem_consolidada
        ),

        calculo AS (
            SELECT
                eb.etapa,
                eb.ordem,

                COALESCE(e.total_oportunidades, 0) AS total_oportunidades,
                e.media_dias,

                LAG(COALESCE(e.total_oportunidades, 0)) OVER (
                    ORDER BY eb.ordem
                ) AS total_etapa_anterior

            FROM etapas_base eb

            LEFT JOIN etapas e
                ON e.ordem = eb.ordem
        )

        SELECT
            etapa,
            ordem,
            total_oportunidades,

            CASE
                WHEN total_etapa_anterior IS NULL THEN NULL
                WHEN total_etapa_anterior = 0 THEN 0
                ELSE ROUND(
                    total_oportunidades::numeric
                    / total_etapa_anterior * 100,
                    1
                )
            END AS taxa_conversao,

            media_dias

        FROM calculo
        ORDER BY ordem;
        `
        const dbresponse = await dbquery(query, [status?.length ? status : null, start_date, end_date]);
        res.json(dbresponse.rows);
    } catch (error) {
        next(error);
    }
}

export const getFunilByUnidade = async(req, res, next) => {
    try {
        const { status, unidade_negocio_id, start_date, end_date } = req.query
        let query = `
        SELECT
            ef.id AS etapa_id,
            ef.nome AS etapa,
            COUNT(DISTINCT o.id) AS quantidade_clientes,
            COALESCE(
                SUM(o.valor_estimado),
                0
            ) AS valor_pipeline,
            ROUND(
                COALESCE(
                    AVG(o.probabilidade),
                    0
                ),
                1
            ) AS probabilidade_media,
            COALESCE(
                SUM(
                    o.valor_estimado
                    * COALESCE(o.probabilidade, 0)
                    / 100
                ),
                0
            ) AS valor_ponderado
        FROM public.etapa_funil ef
        LEFT JOIN public.oportunidade o
            ON o.etapa_id = ef.id
            AND (
                $1::text[] IS NULL
                OR LOWER(o.status) = ANY(
                    SELECT LOWER(status)
                    FROM unnest($1::text[]) AS status
                )
            )
            AND (
                $2::bigint IS NULL
                OR o.unidade_negocio_id = $2::bigint
            )
            AND (
                $3::date IS NULL
                OR o.data_criacao >= $3::date
            )
            AND (
                $4::date IS NULL
                OR o.data_criacao < $4::date
            )
        WHERE
            (
                $2::bigint IS NULL
                OR ef.unidade_negocio_id = $2::bigint
            )
        GROUP BY
            ef.id,
            ef.nome,
            ef.ordem
        ORDER BY
            ef.ordem;`
        const dbresponse = await dbquery(query, [status?.length ? status : null, unidade_negocio_id, start_date, end_date ])
        res.json((dbresponse).rows)
    } catch (error) {
        next(error);
    }
}


export const getFunilHistoricoByUnidade = async(req, res, next) => {
    try {
        const { status, unidade_negocio_id, start_date, end_date } = req.query
        let query = `
        WITH etapas AS (
            SELECT
                u.id AS unidade_negocio_id,
                u.nome AS unidade_negocio,
                ef.id AS etapa_id,
                ef.nome AS etapa,
                ef.ordem
            FROM public.unidade_negocio u
            INNER JOIN public.etapa_funil ef
                ON ef.unidade_negocio_id = u.id
            WHERE
                (
                    $2::bigint IS NULL
                    OR u.id = $2::bigint
                )
        ),
        historico AS (
            SELECT
                o.unidade_negocio_id,
                h.etapa_id,
                COUNT(DISTINCT h.oportunidade_id) AS oportunidades,
                ROUND(
                    AVG(
                        EXTRACT(
                            EPOCH FROM (
                                COALESCE(
                                    h.data_saida,
                                    NOW()::timestamp
                                ) - h.data_entrada
                            )
                        ) / 86400
                    )::numeric,
                    1
                ) AS tempo_medio
            FROM public.historico_oportunidade h
            INNER JOIN public.oportunidade o
                ON o.id = h.oportunidade_id
            WHERE
                (
                    $1::text[] IS NULL
                    OR LOWER(o.status) = ANY(
                        SELECT LOWER(s)
                        FROM unnest($1::text[]) AS s
                    )
                )

                AND (
                    $3::date IS NULL
                    OR o.data_criacao >= $3::date
                )

                AND (
                    $4::date IS NULL
                    OR o.data_criacao < $4::date
                )
            GROUP BY
                o.unidade_negocio_id,
                h.etapa_id
        ),
        dados AS (
            SELECT
                e.*,

                COALESCE(h.oportunidades, 0) AS oportunidades,
                h.tempo_medio

            FROM etapas e

            LEFT JOIN historico h
                ON h.unidade_negocio_id = e.unidade_negocio_id
                AND h.etapa_id = e.etapa_id
        ),
        calculo AS (
            SELECT
                *,

                LAG(oportunidades) OVER (
                    PARTITION BY unidade_negocio_id
                    ORDER BY ordem
                ) AS oportunidades_anterior

            FROM dados
        )
        SELECT
            unidade_negocio_id,
            unidade_negocio,
            etapa_id,
            etapa,
            ordem,
            oportunidades,
            CASE
                WHEN oportunidades_anterior IS NULL THEN NULL
                WHEN oportunidades_anterior = 0 THEN 0
                ELSE ROUND(
                    oportunidades::numeric
                    / oportunidades_anterior * 100,
                    1
                )
            END AS taxa_conversao,
            tempo_medio
        FROM calculo
        ORDER BY
            unidade_negocio_id,
            ordem;
        `
        const dbresponse = await dbquery(query, [status?.length ? status : null, unidade_negocio_id, start_date, end_date ])
        res.json((dbresponse).rows)
    } catch (error) {
        next(error);
    }
}