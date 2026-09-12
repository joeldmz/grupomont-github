import { dbquery } from '../config/database.js';

export const getTotalClientes = async (req, res, next) => {
  try {
    const { status } = req.query;  
    let query = `
        SELECT
            COUNT(DISTINCT c.cliente_id) AS clientes_ativos,
            COALESCE(SUM(c.quantidade_vidas), 0) AS vidas_ativas
        FROM public.contratacao c
        INNER JOIN public.oportunidade o
            ON o.id = c.oportunidade_id
        WHERE o.unidade_negocio_id = 1 AND 
        (
            $1::text IS NULL
            OR c.status = $1::text
        )` 
        ;
    const dbresult = await dbquery(query, [status]);
    res.json(dbresult.rows ? dbresult.rows[0] : {});
  } catch (error) {
    next(error);
  }
};


export const getClientes = async(req, res, next) => {
    try {
        const { unidade_negocio_id, status } = req.query;
        let query = `
            SELECT
                c.id AS cliente_id,
                c.razao_social AS cliente,
                ps.nome AS plano,
                ct.quantidade_vidas,
                ct.valor_mensal_plano,
                ct.status AS status_contratacao,
                ef.ordem,
                ef.nome AS etapa,
                co.nome AS consultor
            FROM public.cliente c

            INNER JOIN public.oportunidade o
                ON o.cliente_id = c.id

            LEFT JOIN public.contratacao ct
                ON ct.oportunidade_id = o.id

            LEFT JOIN public.plano_saude ps
                ON ps.id = COALESCE(ct.plano_id, o.plano_id)

            INNER JOIN public.etapa_funil ef
                ON ef.id = o.etapa_id

            LEFT JOIN public.consultor co
                ON co.id = o.consultor_id

            WHERE o.unidade_negocio_id = 1

            AND 
            (
                $1::text IS NULL
                OR c.status = $1::text
            )

            ORDER BY ct.quantidade_vidas ASC;
        `
        const dbresult = await dbquery(query, [status]);
        res.json(dbresult.rows);
    } catch (error) {
        next(error);
    }
}