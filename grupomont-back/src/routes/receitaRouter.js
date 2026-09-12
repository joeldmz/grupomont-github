import { Router } from 'express';

import { 
    getReceitaByPeriodo, 
    getTotalReceita, 
    getTotalReceitaByUnidade , 
    getValorMensalCarteira 
} from '../controllers/receitaController.js';

const router = Router();

router.get('/total', getTotalReceita);
router.get('/unidade', getTotalReceitaByUnidade);
router.get('/carteira', getValorMensalCarteira);
router.get('/periodo', getReceitaByPeriodo);

export default router;