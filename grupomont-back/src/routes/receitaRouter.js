import { Router } from 'express';

import { 
    getReceitaByPeriodo, 
    getTotalReceita, 
    getTotalReceitaByUnidade , 
    getValorMensalCarteira 
} from '../controllers/receitaController.js';

const router = Router();

router.get('/total', getTotalReceita);// mantener
router.get('/unidade', getTotalReceitaByUnidade);// mentener
router.get('/carteira', getValorMensalCarteira);// mentener
router.get('/periodo', getReceitaByPeriodo) //mantener

export default router;