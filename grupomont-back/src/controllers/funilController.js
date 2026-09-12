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

                WHERE c.status = 'Ativa' AND o.status IN ('Aberta', 'Ganha')

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
        const dbresponse = await dbquery(query);
        res.json(dbresponse.rows);
    } catch (error) {
        next(error);
    }
}

export const getHistoricoFunilConsolidado = async(req, res, next) => {
    try {
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

            WHERE c.status = 'Ativa' AND o.status IN ('Aberta', 'Ganha')
            AND vh.data_entrada IS NOT NULL
            AND vh.data_entrada >= '2026-08-01'
            AND vh.data_entrada <= '2026-09-03'

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
        const dbresponse = await dbquery(query);
        res.json(dbresponse.rows);
    } catch (error) {
        next(error);
    }
}

export const getFunilByUnidade = async(req, res, next) => {
    try {
        const { unidade_negocio_id, start_date, end_date } = req.query
        let query = `
        SELECT
            ef.id AS etapa_id,
            ef.nome AS etapa,
            COUNT(DISTINCT o.id) AS quantidade_clientes,
            COALESCE(SUM(o.valor_estimado), 0) AS valor_pipeline,
            COALESCE(
                SUM(o.valor_estimado * COALESCE(o.probabilidade, 0) / 100),
                0
            ) AS valor_ponderado
        FROM public.etapa_funil ef
        LEFT JOIN public.oportunidade o
            ON o.etapa_id = ef.id
        AND o.status NOT IN ('Perdida')
        AND($1::numeric IS NULL OR o.unidade_negocio_id = $1::numeric)
        AND ($2::date IS NULL OR o.data_criacao >= $2::date)
        AND ($3::date IS NULL OR o.data_criacao < $3::date)
        WHERE
        (
            $1::numeric IS NULL
            OR ef.unidade_negocio_id = $1::numeric
        )
        GROUP BY
            ef.id,
            ef.nome,
            ef.ordem
        ORDER BY ef.ordem;`
        const dbresponse = await dbquery(query, [ unidade_negocio_id, start_date, end_date ])
        res.json((dbresponse).rows)
    } catch (error) {
        next(error);
    }
}