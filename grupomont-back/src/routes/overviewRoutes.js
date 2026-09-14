import { Router } from 'express';
import { 
    getOportunidadePipeline,
    getMarketingPerformance,
    getOportunidadePipelineByUnidade
} from '../controllers/overviewController.js';

const router = Router();

router.get('/pipeline', getOportunidadePipeline);
router.get('/pipeline/unidade', getOportunidadePipelineByUnidade);
router.get('/marketing/performance', getMarketingPerformance);

export default router;