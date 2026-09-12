import { dbquery } from '../config/database.js';

export const getMainData = async(req, res, next) => {
    try {
        const { start_date, end_date } = req.query
        let query = `
            WITH pipeline AS (
                SELECT
                    COALESCE(SUM(o.valor_estimado), 0) AS pipeline_patrimonial,
                    COUNT(DISTINCT o.cliente_id) AS quantidade_clientes
                FROM public.oportunidade o
                WHERE o.unidade_negocio_id = 2
                AND o.status NOT IN ('Ganha', 'Perdida')
                AND ($1::date IS NULL OR o.data_criacao >= $1::date)
                AND ($2::date IS NULL OR o.data_criacao < $2::date)
            ),

            operacoes AS (
                SELECT
                    COALESCE(SUM(op.valor_operacao), 0) AS volume_transacionado,
                    COALESCE(SUM(op.comissao), 0) AS comissao
                FROM public.operacao_patrimonial op
                INNER JOIN public.oportunidade o
                    ON o.id = op.oportunidade_id
                WHERE o.unidade_negocio_id = 2
                AND op.status = 'Concluída'
                AND ($1::date IS NULL OR op.data_conclusao >= $1::date)
                AND ($2::date IS NULL OR op.data_conclusao < $2::date)
            ),

            receita AS (
                SELECT
                    COALESCE(SUM(r.valor), 0) AS receita_realizada
                FROM public.receita r
                INNER JOIN public.oportunidade o
                    ON o.id = r.oportunidade_id
                WHERE o.unidade_negocio_id = 2
                AND r.status = 'Realizada'
                AND ($1::date IS NULL OR r.data >= $1::date)
                AND ($2::date IS NULL OR r.data < $2::date)
            )

            SELECT
                p.quantidade_clientes,
                p.pipeline_patrimonial,
                op.volume_transacionado,
                op.comissao,
                r.receita_realizada
            FROM pipeline p
            CROSS JOIN operacoes op
            CROSS JOIN receita r;
        `
        const dbresponse = await dbquery(query, [start_date, end_date])
        res.json(dbresponse.rows.length > 0 ? dbresponse.rows[0] : {})
    } catch (error) {
        next(error)
    }
}

export const getOperacoes = async(req, res, next) => {
    try {
        const { start_date, end_date } = req.query
        let query = `
            SELECT
                op.cliente_id,
                c.razao_social AS cliente,
                COUNT(*) AS total_operacoes,
                COALESCE(SUM(op.valor_operacao), 0) AS valor_total_operacoes,
                COALESCE(SUM(
                    CASE
                        WHEN op.status = 'Concluída'
                        THEN op.valor_operacao
                        ELSE 0
                    END
                ), 0) AS valor_concluido,
                COALESCE(SUM(
                    CASE
                        WHEN op.status = 'Em andamento'
                        THEN op.valor_operacao
                        ELSE 0
                    END
                ), 0) AS valor_em_andamento,
                COALESCE(SUM(
                    CASE
                        WHEN op.status = 'Prevista'
                        THEN op.valor_operacao
                        ELSE 0
                    END
                ), 0) AS valor_previsto,
                COALESCE(SUM(op.comissao), 0) AS comissao_total
            FROM operacao_patrimonial op
            INNER JOIN cliente c
                ON c.id = op.cliente_id
            WHERE ($1::date IS NULL OR op.data_inicio >= $1::date)
            AND ($2::date IS NULL OR op.data_inicio <= $2::date)
            GROUP BY
                op.cliente_id,
                c.razao_social
            ORDER BY
                valor_total_operacoes DESC;
        `
        const dbresponse = await dbquery(query, [start_date, end_date])
        res.json(dbresponse.rows)
    } catch (error) {
        next(error)
    }
}

export const getOperacaoByCliente = async(req, res, next) => {
    try {
        const { id, start_date, end_date } = req.query
        let query = `
            SELECT
                op.id,
                op.cliente_id,
                c.razao_social AS cliente,
                con.id AS consultor_id,
                con.nome AS consultor,
                op.tipo_operacao,
                op.valor_operacao,
                op.data_inicio,
                op.data_conclusao,
                op.status,
                op.data_previsao_conclusao,
                op.comissao
            FROM operacao_patrimonial op
            INNER JOIN cliente c
                ON c.id = op.cliente_id
            INNER JOIN oportunidade o
                ON o.id = op.oportunidade_id
            LEFT JOIN consultor con
                ON con.id = o.consultor_id
            WHERE op.cliente_id = $1
            AND ($2::date IS NULL OR op.data_inicio >= $2::date)
            AND ($3::date IS NULL OR op.data_inicio <= $3::date)
            ORDER BY op.data_inicio DESC;
        `
        const dbresponse = await dbquery(query, [id, start_date, end_date])
        res.json(dbresponse.rows)
    } catch (error) {
        next(error)
    }
}