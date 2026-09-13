import { dbquery } from '../config/database.js';

export const getContratacoes = async(req, res, next) => {
    try {
        
        const { 
            empresa_id, 
            psaude_id, 
            campanha_id, 
            consultor_id, 
            start_date, 
            end_date 
        } = req.query;

        let query = `
            select
                ct.id as contratacao_id,
                e.razao_social as empresa,
                p.nome as plano,
                c.nome as consultor,
                cmp.nome as campanha,
                ct.data_contratacao,
                ct.quantidade_vidas,
                ct.valor_mensal_plano,
                ct.status
            from contratacao ct
            join oportunidade o on o.id = ct.oportunidade_id
            join empresa e on e.id = o.empresa_id
            join plano_saude p on p.id = ct.plano_id
            left join consultor c on c.id = o.consultor_id
            left join campanha cmp on cmp.id = o.campanha_id
            order by ct.data_contratacao desc;
        `
        const dbresponse = await dbquery(query);
        res.json(dbresponse.rows);
    } catch (error) {
        next(error)
    }
} 

export const getContratacoesByPeriodo = async(req, res, next) => {
    try {
        const { interval } = req.query;
        let query = `
            WITH meses AS (
                SELECT generate_series(
                    DATE_TRUNC('month', CURRENT_DATE) - ($1::int * INTERVAL '1 month'),
                    DATE_TRUNC('month', CURRENT_DATE),
                    INTERVAL '1 month'
                )::date AS mes
            ),

            contratacoes_por_mes AS (
                SELECT
                    DATE_TRUNC('month', c.data_contratacao)::date AS mes,
                    COUNT(*) AS contratacoes
                FROM public.contratacao c
                INNER JOIN public.oportunidade o
                    ON o.id = c.oportunidade_id
                WHERE o.unidade_negocio_id = 1
                AND c.data_contratacao >= (
                    DATE_TRUNC('month', CURRENT_DATE)
                    - ($1::int * INTERVAL '1 month')
                )
                GROUP BY DATE_TRUNC('month', c.data_contratacao)
            )

            SELECT
                TO_CHAR(m.mes, 'YYYY-MM') AS periodo,
                TO_CHAR(m.mes, 'Mon') AS mes,
                COALESCE(cp.contratacoes, 0) AS contratacoes
            FROM meses m
            LEFT JOIN contratacoes_por_mes cp
                ON cp.mes = m.mes
            ORDER BY m.mes;
        `
        const dbresponse = await dbquery(query, [interval]);
        res.json(dbresponse.rows);
    } catch (error) {
        next(error)
    }
}


export const getContratacaoByPlano = async(req, res, next) => {
    try {
        const { start_date, end_date} = req.query
        let query = `
            SELECT
                ps.id AS plano_id,
                ps.nome AS plano,
                COUNT(DISTINCT c.id) AS quantidade_contratacoes,
                COALESCE(SUM(r.valor), 0) AS receita
            FROM public.contratacao c

            INNER JOIN public.plano_saude ps
                ON ps.id = c.plano_id

            INNER JOIN public.oportunidade o
                ON o.id = c.oportunidade_id

            LEFT JOIN public.receita r
                ON r.contratacao_id = c.id
                AND r.status = 'Realizada'
                AND ($1::date IS NULL OR r.data >= $1::date)
                AND ($2::date IS NULL OR r.data < $2::date)

            WHERE o.unidade_negocio_id = 1
            AND ($1::date IS NULL OR c.data_contratacao >= $1::date)
            AND ($2::date IS NULL OR c.data_contratacao < $2::date)

            GROUP BY
                ps.id,
                ps.nome

            ORDER BY quantidade_contratacoes DESC
            LIMIT 4;
        `
        const dbresponse = await dbquery(query, [start_date, end_date]);
        res.json(dbresponse.rows)
    } catch (error) {
        
    }
}


export const getContratacaoByOperadora = async(req, res, next) => {
    try {
        const { start_date, end_date } = req.query
        let query = `
            SELECT
                op.id AS operadora_id,
                op.nome AS operadora,
                COUNT(DISTINCT c.id) AS quantidade_contratacoes,
                COALESCE(SUM(r.valor), 0) AS receita
            FROM public.contratacao c
            INNER JOIN public.plano_saude ps
                ON ps.id = c.plano_id
            INNER JOIN public.operadora op
                ON op.id = ps.operadora_id
            INNER JOIN public.oportunidade o
                ON o.id = c.oportunidade_id
            LEFT JOIN public.receita r
                ON r.contratacao_id = c.id
                AND r.status = 'Realizada'
                AND ($1::date IS NULL OR r.data >= $1::date)
                AND ($2::date IS NULL OR r.data < $2::date)
            WHERE o.unidade_negocio_id = 1
            AND ($1::date IS NULL OR c.data_contratacao >= $1::date)
            AND ($2::date IS NULL OR c.data_contratacao < $2::date)
            GROUP BY
                op.id,
                op.nome
            ORDER BY quantidade_contratacoes DESC
            LIMIT 4;
        `
        const dbresponse = await dbquery(query, [start_date, end_date]);
        res.json(dbresponse.rows)
    } catch (error) {
        next(error);
    }
}


