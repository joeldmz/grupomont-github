import { dbquery } from '../config/database.js';

export const getMainKpis = async(req, res, next) => {
    try {
        const { data_inicio, data_fim } = req.query;
        let query = `
            WITH clientes AS (
                SELECT DISTINCT o.cliente_id
                FROM public.oportunidade o
                WHERE o.unidade_negocio_id = 3
                AND ($1::date IS NULL OR o.data_criacao >= $1::date)
                AND ($2::date IS NULL OR o.data_criacao < $2::date)

                UNION

                SELECT DISTINCT c.cliente_id
                FROM public.contrato c
                INNER JOIN public.oportunidade o
                    ON o.id = c.oportunidade_id
                WHERE o.unidade_negocio_id = 3
                AND ($1::date IS NULL OR c.data_assinatura >= $1::date)
                AND ($2::date IS NULL OR c.data_assinatura < $2::date)

                UNION

                SELECT DISTINCT c.cliente_id
                FROM public.projeto p
                INNER JOIN public.contrato c
                    ON c.id = p.contrato_id
                INNER JOIN public.oportunidade o
                    ON o.id = c.oportunidade_id
                WHERE o.unidade_negocio_id = 3
                AND ($1::date IS NULL OR p.data_inicio >= $1::date)
                AND ($2::date IS NULL OR p.data_inicio < $2::date)
            ),

            projetos AS (
                SELECT COUNT(DISTINCT p.id) AS quantidade_projetos
                FROM public.projeto p
                INNER JOIN public.contrato c
                    ON c.id = p.contrato_id
                INNER JOIN public.oportunidade o
                    ON o.id = c.oportunidade_id
                WHERE o.unidade_negocio_id = 3
                AND ($1::date IS NULL OR p.data_inicio >= $1::date)
                AND ($2::date IS NULL OR p.data_inicio < $2::date)
            ),

            receitas AS (
                SELECT
                    COALESCE(
                        SUM(
                            CASE
                                WHEN r.tipo = 'Projeto'
                                THEN r.valor
                                ELSE 0
                            END
                        ),
                        0
                    ) AS receita_pontual,

                    COALESCE(
                        SUM(
                            CASE
                                WHEN r.tipo = 'Recorrência'
                                THEN r.valor
                                ELSE 0
                            END
                        ),
                        0
                    ) AS receita_recorrente

                FROM public.receita r
                WHERE r.unidade_negocio_id = 3
                AND r.status = 'Realizada'
                AND ($1::date IS NULL OR r.data >= $1::date)
                AND ($2::date IS NULL OR r.data < $2::date)
            )

            SELECT
                (SELECT COUNT(*) FROM clientes) AS quantidade_clientes,
                projetos.quantidade_projetos,
                receitas.receita_pontual,
                receitas.receita_recorrente
            FROM projetos
            CROSS JOIN receitas;
        `;
        const dbresult = await dbquery(query, [ data_inicio, data_fim ]);
        res.json(dbresult.rows ? dbresult.rows[0] : {});
    } catch (error) {
        next(error);
    }
}

export const getProjetos = async(req, res, next) => {
    try {
        const { data_inicio, data_fim } = req.query;
        let query = `
            SELECT
                p.id,
                p.nome,
                p.status,
                p.data_inicio,
                p.data_previsao_entrega,
                p.data_entrega,
                p.valor_projeto,
                c.razao_social AS cliente,
                e.id AS equipe_id,
                e.nome AS equipe
            FROM public.projeto p
            INNER JOIN public.contrato ct
                ON ct.id = p.contrato_id
            INNER JOIN public.oportunidade o
                ON o.id = ct.oportunidade_id
            INNER JOIN public.cliente c
                ON c.id = ct.cliente_id
            LEFT JOIN public.equipe e
                ON e.id = p.equipe_id
            WHERE o.unidade_negocio_id = 3
            AND ($1::date IS NULL OR p.data_inicio >= $1::date)
            AND ($2::date IS NULL OR p.data_inicio < $2::date)
            ORDER BY p.data_inicio DESC;
                    `;
        const dbresult = await dbquery(query, [ data_inicio, data_fim ]);
        res.json(dbresult.rows);
    } catch (error) {
        next(error);
    }
}


export const getDetalheProjeto = async(req, res, next) => {
    try {
        const { id } = req.query;
        let query = `
        SELECT
            p.id AS projeto_id,
            p.nome AS projeto,
            p.descricao,
            p.status AS status_projeto,
            p.data_inicio,
            p.data_previsao_entrega,
            p.data_entrega,
            p.valor_projeto,

            c.id AS contrato_id,
            c.numero_contrato,
            c.valor_contrato,
            c.tipo_contrato,
            c.tipo_cobranca,
            c.data_assinatura,
            c.data_inicio AS contrato_inicio,
            c.data_fim AS contrato_fim,
            c.status AS status_contrato,

            e.id AS equipe_id,
            e.nome AS equipe,

            cli.id AS cliente_id,
            cli.razao_social,
            cli.cnpj,
            cli.cidade,
            cli.estado,
            cli.status AS status_cliente

        FROM public.projeto p

        INNER JOIN public.contrato c
            ON c.id = p.contrato_id

        INNER JOIN public.cliente cli
            ON cli.id = c.cliente_id

        INNER JOIN public.oportunidade o
            ON o.id = c.oportunidade_id
        
        LEFT JOIN public.equipe e
            ON e.id = p.equipe_id

        WHERE p.id = $1
        AND o.unidade_negocio_id = 3;
        `;
        const dbresult = await dbquery(query, [ id ]);
        res.json(dbresult.rows.length > 0 ? dbresult.rows[0] : {});
    } catch (error) {
        next(error);
    }
}
