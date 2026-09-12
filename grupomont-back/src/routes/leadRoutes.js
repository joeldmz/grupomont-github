import { Router } from 'express';
import { 
    getLeads,
    getLeadByCampanha ,
    getTotalLead,
    getLeadByUnidade
} from '../controllers/leadController.js';

const router = Router();

router.get('/', getLeads);
router.get('/total', getTotalLead);
router.get('/unidade', getLeadByUnidade)

//ver
// router.get('/atingimento', getTotalLeadsByAtingimento)
// router.get('/campanha', getLeadByCampanha)

export default router;