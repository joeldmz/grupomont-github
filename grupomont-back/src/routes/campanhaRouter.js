import { Router } from 'express';
import { 
    getCampanha, 
    getCampanhaById, 
    getInvestimento, 
    getResultadoByCanal, 
    getTotalCampanhas 
} from '../controllers/campanhaController.js';

const router = Router();

router.get('/', getCampanha);
router.get('/total', getTotalCampanhas);
router.get('/info', getCampanhaById);
router.get('/investimento', getInvestimento);// mantener (ver si ser reemplazado por total)
router.get('/canal', getResultadoByCanal);

export default router;