import { dbquery } from '../config/database.js';

export const getTotalReceita = async(req, res, next) => {
     try {
        const {data_inicio, data_fim} = req.query;
        let query = `
        WITH oportunidades AS (
            SELECT
                o.unidade_negocio_id,
                COUNT(*) AS quantidade_oportunidades,
                COUNT(*) FILTER (
                    WHERE o.status = 'Ganha'
                ) AS oportunidades_ganhas,
                COALESCE(SUM(o.valor_estimado), 0) AS valor_total_oportunidades,
                COALESCE(
                    SUM(o.valor_estimado) FILTER (
                        WHERE o.status = 'Ganha'
                    )
                    / NULLIF(
                        COUNT(*) FILTER (
                            WHERE o.status = 'Ganha'
                        ),
                        0
                    ),
                    0
                ) AS ticket_medio
            FROM public.oportunidade o
            WHERE ($1::date IS NULL OR o.data_criacao >= $1::date)
            AND ($2::date IS NULL OR o.data_criacao < $2::date)
            GROUP BY o.unidade_negocio_id
        ),
        receitas AS (
            SELECT
                r.unidade_negocio_id,
                COALESCE(SUM(r.valor), 0) AS receita_realizada
            FROM public.receita r
            WHERE r.status = 'Realizada'
            AND ($1::date IS NULL OR r.data >= $1::date)
            AND ($2::date IS NULL OR r.data < $2::date)
            GROUP BY r.unidade_negocio_id
        )
        SELECT
            un.id AS unidade_negocio_id,
            un.nome AS empresa,
            COALESCE(r.receita_realizada, 0) AS receita_realizada,
            COALESCE(o.quantidade_oportunidades, 0) AS quantidade_oportunidades,
            COALESCE(o.oportunidades_ganhas, 0) AS oportunidades_ganhas,
            COALESCE(o.valor_total_oportunidades, 0) AS valor_total_oportunidades,
            COALESCE(o.ticket_medio, 0) AS ticket_medio
        FROM public.unidade_negocio un
        LEFT JOIN oportunidades o
            ON o.unidade_negocio_id = un.id
        LEFT JOIN receitas r
            ON r.unidade_negocio_id = un.id
        WHERE un.id IN (1, 2, 3)
        ORDER BY un.id;
        `;
        const dbresult = await dbquery(query, [data_inicio, data_fim]);
        res.json(dbresult.rows);
    } catch (error) {
        next(error);
    }
}


export const getTotalReceitaByUnidade = async(req, res, next) => {
    try {
        const {unidade_negocio_id, data_inicio, data_fim} = req.query;
        let query = `
        SELECT
            COALESCE(SUM(r.valor), 0) AS receita_realizada
        FROM public.receita r
        INNER JOIN public.contratacao c
            ON c.id = r.contratacao_id
        INNER JOIN public.oportunidade o
            ON o.id = c.oportunidade_id
        WHERE r.status = 'Realizada'
        AND
        (
            $1::numeric IS NULL
            OR o.unidade_negocio_id = $1::numeric
        )
        AND (
            $2::date IS NULL
            OR r.data >= $2::date
        )
        AND (
            $3::date IS NULL
            OR r.data < $3::date
        )`;
        const dbresult = await dbquery(query, [unidade_negocio_id, data_inicio, data_fim]);
        res.json(dbresult.rows ? dbresult.rows[0] : {});
    } catch (error) {
        next(error);
    }
}


// esto es solo para monteseguro chequar query y fechas
export const getValorMensalCarteira = async(req, res, next) => {
    try {
        const { unidade_negocio_id } = req.query;
        let query = `
        SELECT
            COALESCE(SUM(c.valor_mensal_plano), 0) AS valor_mensal_carteira
        FROM public.contratacao c
        INNER JOIN public.oportunidade o
            ON o.id = c.oportunidade_id
        WHERE c.status = 'Ativa'
        AND o.unidade_negocio_id = $1;`

        const dbresult = await dbquery(query, [unidade_negocio_id]);
        res.json(dbresult.rows ? dbresult.rows[0] : {});
    } catch (error) {
        next(error);
    }
}


export const getReceitaByPeriodo = async(req, res, next) => {
    try {
        const { unidade_negocio_id, start_date, end_date } = req.query;
        let query = `
        WITH parametros AS (
            SELECT
                COALESCE($2::date, date_trunc('month', CURRENT_DATE)::date) AS data_inicio,
                COALESCE(
                    $3::date,
                    (date_trunc('month', CURRENT_DATE) + INTERVAL '1 month')::date
                ) AS data_fim
        ),
        periodos AS (
            SELECT
                2 AS ordem,
                data_inicio - 2 * (data_fim - data_inicio) AS inicio,
                data_inicio - (data_fim - data_inicio) AS fim
            FROM parametros

            UNION ALL

            SELECT
                1 AS ordem,
                data_inicio - (data_fim - data_inicio),
                data_inicio
            FROM parametros

            UNION ALL

            SELECT
                0 AS ordem,
                data_inicio,
                data_fim
            FROM parametros
        )
        SELECT
            TO_CHAR(
                p.inicio,
                'Mon YYYY'
            ) AS periodo,

            COALESCE(
                SUM(r.valor),
                0
            ) AS receita

        FROM periodos p

        LEFT JOIN public.receita r
            ON r.status = 'Realizada'
            AND r.data >= p.inicio
            AND r.data < p.fim
            AND r.unidade_negocio_id IN (1, 2, 3)
            AND ($1::bigint IS NULL OR r.unidade_negocio_id = $1::bigint)

        GROUP BY
            p.ordem,
            p.inicio

        ORDER BY
            p.ordem;
        `
        const dbresult = await dbquery(query, [unidade_negocio_id, start_date, end_date]);
        res.json(dbresult.rows);
    } catch (error) {
        next(error);
    }
}
