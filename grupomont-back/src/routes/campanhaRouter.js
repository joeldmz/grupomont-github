import { Router } from 'express';
import { 
    getCampanha, 
    getCampanhaById, 
    getInvestimento, 
    getResultadoByCanal, 
    getTotalCampanhas 
} from '../controllers/campanhaController.js';

const router = Router();

router.get('/', getCampanha);// mantener
router.get('/total', getTotalCampanhas);// investimento //mantener
router.get('/info', getCampanhaById);//mantener
router.get('/investimento', getInvestimento);// mantener (ver si ser reemplazado por total)
router.get('/canal', getResultadoByCanal);//mantener

export default router;