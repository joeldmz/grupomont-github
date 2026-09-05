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