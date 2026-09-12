import { Router } from 'express';
import { 
    getOportunidadePipeline,
    getMarketingPerformance
} from '../controllers/overviewController.js';

const router = Router();

router.get('/pipeline', getOportunidadePipeline);
router.get('/marketing/performance', getMarketingPerformance);

export default router;