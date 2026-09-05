import { dbquery } from '../config/database.js';

export const getReceita = async(req, res, next) => {
    try {
        let query = `
        SELECT
            m.id AS meta_id,
            m.valor_meta AS target,
            COALESCE(SUM(r.valor), 0) AS value,
            COALESCE(SUM(r.valor), 0) - m.valor_meta AS diferenca,
            m.periodo_inicio,
            m.periodo_fim,

            CASE
                WHEN m.valor_meta > 0 THEN
                    ROUND(
                        (COALESCE(SUM(r.valor), 0) / m.valor_meta) * 100,
                        2
                    )
                ELSE 0
            END AS percentual_atingido,

            CASE
                WHEN COALESCE(SUM(r.valor), 0) >= m.valor_meta
                    THEN 'Atingida'
                ELSE 'Em andamento'
            END AS status_meta

        FROM meta m

        LEFT JOIN receita r
            ON r.status = 'Realizada'
            AND r.data BETWEEN m.periodo_inicio AND m.periodo_fim

        WHERE m.tipo_meta = 'Receita'
        AND m.unidade_negocio_id = 1

        GROUP BY
            m.id,
            m.valor_meta,
            m.periodo_inicio,
            m.periodo_fim;
        `
        const result = await dbquery(query);
        res.json(result.rows.length > 0 ? result.rows[0] : {})
    } catch (error) {
        next(error)
    }
}

export const getReceitaByUnidade = async(req, res, next) => {
    try {
        let query = `
        SELECT
            u.id AS unidade_negocio_id,
            u.nome AS title,

            COALESCE(m.valor_meta, 0) AS target,

            COALESCE(SUM(r.valor), 0) AS value,
            CASE
                WHEN m.valor_meta IS NULL THEN 'Sem meta'
                WHEN COALESCE(SUM(r.valor), 0) >= m.valor_meta THEN 'Atingida'
                ELSE 'Em andamento'
            END AS status_meta

        FROM unidade_negocio u

        LEFT JOIN meta m
            ON m.unidade_negocio_id = u.id
            AND m.tipo_meta = 'Receita'

        LEFT JOIN receita r
            ON r.unidade_negocio_id = u.id
            AND r.status = 'Realizada'
            AND r.data BETWEEN m.periodo_inicio AND m.periodo_fim

        GROUP BY
            u.id,
            u.nome,
            m.id,
            m.valor_meta

        ORDER BY
            value DESC;
        `
        const dbresponse = await dbquery(query);
        res.json(dbresponse.rows);
    } catch (error) {
        next(error)
    }
}



export const getClientes = async(req, res, next) => {
    try {
        let query = `
            
        `
         const dbresponse = await dbquery(query);
        res.json(dbresponse.rows);
        
    } catch (error) {
        next(error)
    }
}


export const getTaixaConversao = async(req, res, next) => {
    try {
        let query = `
        WITH leads AS (
            SELECT
                c.unidade_negocio_id,
                COUNT(l.id) AS total_leads
            FROM campanha c
            LEFT JOIN lead l
                ON l.campanha_id = c.id
            WHERE c.status = 'Ativa'
            GROUP BY c.unidade_negocio_id
        ),

        oportunidades AS (
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
            un.nome AS unidade_negocio,

            COALESCE(l.total_leads, 0) AS total_leads,
            COALESCE(o.total_oportunidades, 0) AS total_oportunidades,

            COALESCE(
                ROUND(
                    o.total_oportunidades::numeric
                    / NULLIF(l.total_leads, 0)
                    * 100,
                    2
                ),
                0
            ) AS taxa_conversao

        FROM unidade_negocio un

        LEFT JOIN leads l
            ON l.unidade_negocio_id = un.id

        LEFT JOIN oportunidades o
            ON o.unidade_negocio_id = un.id

        ORDER BY un.nome;`
        
        const dbresponse = await dbquery(query);
        res.json(dbresponse.rows);
    } catch (error) {
        next(error)
    }
}

export const getOportunidadePipeline = async(req, res, next) => {
    try {
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
                ROUND(
                    SUM(
                        COALESCE(o.valor_estimado, 0) *
                        COALESCE(o.probabilidade, 0) / 100
                    ) FILTER (
                        WHERE LOWER(o.status) = 'aberta'
                    ),
                    2
                ) AS valor_ponderado_abertas
            FROM oportunidade o
            JOIN campanha c
                ON c.id = o.campanha_id

            WHERE c.status = 'Ativa';
        `
        const dbresponse = await dbquery(query);
        res.json(dbresponse.rows.length > 0 ? dbresponse.rows[0] : {});
    } catch (error) {
        next(error)
    }
}



export const getResultadosGerados = async(req, res, next) => {
    try {
        let query = `
        WITH operacoes_por_oportunidade AS (
            SELECT 
                o.id AS oportunidade_id,
                o.campanha_id,
                COUNT(op.id) AS total_operacoes
            FROM oportunidade o
            LEFT JOIN operacao_patrimonial op 
                ON op.oportunidade_id = o.id
            WHERE o.status = 'Ganha'
            GROUP BY o.id, o.campanha_id
        ),

        contratacoes_por_oportunidade AS (
            SELECT 
                o.id AS oportunidade_id,
                o.campanha_id,
                COUNT(ct.id) AS total_contratacoes
            FROM oportunidade o
            LEFT JOIN contratacao ct 
                ON ct.oportunidade_id = o.id
            WHERE o.status = 'Ganha'
            GROUP BY o.id, o.campanha_id
        ),

        contratos_por_oportunidade AS (
            SELECT 
                o.id AS oportunidade_id,
                o.campanha_id,
                COUNT(c.id) AS total_contratos
            FROM oportunidade o
            LEFT JOIN contrato c 
                ON c.oportunidade_id = o.id
            WHERE o.status = 'Ganha'
            GROUP BY o.id, o.campanha_id
        ),

        projetos_por_oportunidade AS (
            SELECT
                o.id AS oportunidade_id,
                o.campanha_id,
                COUNT(p.id) AS total_projetos
            FROM oportunidade o
            LEFT JOIN contrato c
                ON c.oportunidade_id = o.id
            LEFT JOIN projeto p
                ON p.contrato_id = c.id
            WHERE o.status = 'Ganha'
            GROUP BY o.id, o.campanha_id
        )

        SELECT 
            COALESCE(SUM(co.total_contratos), 0) AS total_contratos,
            COALESCE(SUM(op.total_operacoes), 0) AS total_operacoes,
            COALESCE(SUM(ct.total_contratacoes), 0) AS total_contratacoes,
            COALESCE(SUM(pr.total_projetos), 0) AS total_projetos
        FROM campanha ca
        LEFT JOIN contratos_por_oportunidade co
            ON co.campanha_id = ca.id
        LEFT JOIN operacoes_por_oportunidade op
            ON op.campanha_id = ca.id
        LEFT JOIN contratacoes_por_oportunidade ct
            ON ct.campanha_id = ca.id
        LEFT JOIN projetos_por_oportunidade pr
            ON pr.campanha_id = ca.id
        WHERE ca.status = 'Ativa';
        `
        const dbresponse = await dbquery(query);
        res.json(dbresponse.rows.length > 0 ? dbresponse.rows[0] : {});
    } catch (error) {
        next(error)
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
        next(error)
    }
}


/*WITH leads_por_campanha AS (
    SELECT
        campanha_id,
        COUNT(*) AS total_leads
    FROM lead
    GROUP BY campanha_id
),

oportunidades_por_campanha AS (
    SELECT
        campanha_id,
        COUNT(*) AS total_oportunidades
    FROM oportunidade
    GROUP BY campanha_id
),

contratos_por_campanha AS (
    SELECT
        o.campanha_id,
        COUNT(DISTINCT c.id) AS total_contratos
    FROM oportunidade o
    INNER JOIN contrato c
        ON c.oportunidade_id = o.id
    GROUP BY o.campanha_id
),

projetos_por_campanha AS (
    SELECT
        o.campanha_id,
        COUNT(DISTINCT p.id) AS total_projetos
    FROM oportunidade o
    INNER JOIN contrato c
        ON c.oportunidade_id = o.id
    INNER JOIN projeto p
        ON p.contrato_id = c.id
    GROUP BY o.campanha_id
),

receita_por_campanha AS (
    SELECT
        o.campanha_id,
        COALESCE(SUM(r.valor), 0) AS receita_realizada
    FROM oportunidade o
    INNER JOIN receita r
        ON r.contrato_id IN (
            SELECT c.id
            FROM contrato c
            WHERE c.oportunidade_id = o.id
        )
    WHERE r.status = 'Realizada'
    GROUP BY o.campanha_id
)

SELECT
    c.id AS campanha_id,
    c.nome AS campanha,
    c.investimento,

    COALESCE(l.total_leads, 0) AS total_leads,
    COALESCE(o.total_oportunidades, 0) AS total_oportunidades,
    COALESCE(ct.total_contratos, 0) AS total_contratos,
    COALESCE(p.total_projetos, 0) AS total_projetos,
    COALESCE(r.receita_realizada, 0) AS receita_realizada

FROM campanha c

LEFT JOIN leads_por_campanha l
    ON l.campanha_id = c.id

LEFT JOIN oportunidades_por_campanha o
    ON o.campanha_id = c.id

LEFT JOIN contratos_por_campanha ct
    ON ct.campanha_id = c.id

LEFT JOIN projetos_por_campanha p
    ON p.campanha_id = c.id

LEFT JOIN receita_por_campanha r
    ON r.campanha_id = c.id

ORDER BY c.id;*/