import { Router } from 'express';
import { 
    getOportunidadePipeline,
    getMarketingPerformance
} from '../controllers/overviewController.js';

const router = Router();

router.get('/pipeline', getOportunidadePipeline);// mantener
router.get('/marketing/performance', getMarketingPerformance) //mantener

export default router;