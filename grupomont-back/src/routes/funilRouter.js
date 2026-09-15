import { Router } from 'express';
import { 
    getOportunidadeByEtapa, 
    getHistoricoEtapa, 
    getFunilConsolidado, 
    getHistoricoFunilConsolidado, 
    getFunilByUnidade,
    getFunilHistoricoByUnidade
} from '../controllers/funilController.js';

const router = Router();

router.get('/etapa', getOportunidadeByEtapa);
router.get('/historico', getHistoricoEtapa);
router.get('/historico/unidade', getFunilHistoricoByUnidade);
router.get('/consolidado', getFunilConsolidado);
router.get('/consolidado/historico', getHistoricoFunilConsolidado);
router.get('/unidade', getFunilByUnidade);

export default router;