import { dbquery } from '../config/database.js';

export const getLeads = async(req, res, next) => {
    try {
        const resutl = await dbquery('SELECT * FROM lead;');
        res.json(resutl.rows);
    } catch (error) {
        next(error);
    }
}

export const getTotalLead = async(req, res, next) => {
    try {
        const { status, start_date, end_date, campanha_id } = req.query;
        let query = `
        WITH leads_periodo AS (
            SELECT
                COUNT(*) AS value
            FROM public.lead l
            WHERE (
                $1::date IS NULL
                OR l.data_entrada >= $1::date
            )
            AND (
                $2::date IS NULL
                OR l.data_entrada < $2::date
            )
        ),

        meta_leads AS (
            SELECT
                COALESCE(SUM(m.valor_meta), 0) AS target
            FROM public.meta m
            WHERE m.tipo_meta = 'Leads'
        )

        SELECT
            l.value,
            m.target,

            l.value - m.target AS gap,

            ROUND(
                l.value * 100.0 /
                NULLIF(m.target, 0),
                1
            ) AS percentual_meta

        FROM leads_periodo l
        CROSS JOIN meta_leads m;
        `
        const dbresult = await dbquery(query, [start_date, end_date]);
        res.json(dbresult.rows.length > 0 ? dbresult.rows[0] : {});
    } catch (error) {
        next(error);
    }
} 
