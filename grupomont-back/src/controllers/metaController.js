import { dbquery } from '../config/database.js';

/*
$6 = TRUE  → somente metas gerais
$6 = FALSE → somente metas de campanha
$6 = NULL  → todas
*/
export const getMetas = async(req, res, next) => {
    try {
        const {
            unidade_negocio_id,
            campanha_id,
            tipo,
            start_date, 
            end_date,
            meta_geral
        } = req.query;

        let query = `
        SELECT
            m.unidade_negocio_id,
            un.nome AS unidade_negocio,
            m.campanha_id,
            m.tipo_meta,
            m.periodo_inicio,
            m.periodo_fim,
            COALESCE(SUM(m.valor_meta), 0) AS valor_meta
        FROM public.meta m
        INNER JOIN public.unidade_negocio un
            ON un.id = m.unidade_negocio_id
        WHERE
            ($1::bigint IS NULL OR m.unidade_negocio_id = $1::bigint)
            AND ($2::bigint IS NULL OR m.campanha_id = $2::bigint)
            AND ($3::varchar IS NULL OR m.tipo_meta = $3::varchar)
            AND ($4::date IS NULL OR m.periodo_inicio >= $4::date)
            AND ($5::date IS NULL OR m.periodo_fim <= $5::date)
            AND (
                $6::boolean IS NULL
                OR ($6::boolean = TRUE AND m.campanha_id IS NULL)
                OR ($6::boolean = FALSE AND m.campanha_id IS NOT NULL)
            )
        GROUP BY
            m.unidade_negocio_id,
            un.nome,
            m.campanha_id,
            m.tipo_meta,
            m.periodo_inicio,
            m.periodo_fim
        ORDER BY
            m.unidade_negocio_id,
            m.campanha_id,
            m.tipo_meta;
        `
        const dbresult = await dbquery(query, [unidade_negocio_id, campanha_id, tipo, start_date, end_date, meta_geral]);
        res.json(dbresult.rows);
    } catch (error) {
        next(error)
    }
} 