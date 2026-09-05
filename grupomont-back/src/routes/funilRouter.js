import { Router } from 'express';
import { 
    getOportunidadeByEtapa, 
    getHistoricoEtapa, 
    getFunilConsolidado, 
    getHistoricoFunilConsolidado 
} from '../controllers/funilController.js';

const router = Router();

router.get('/etapa', getOportunidadeByEtapa);
router.get('/historico', getHistoricoEtapa);
router.get('/consolidado', getFunilConsolidado);
router.get('/consolidado/historico', getHistoricoFunilConsolidado);

export default router;