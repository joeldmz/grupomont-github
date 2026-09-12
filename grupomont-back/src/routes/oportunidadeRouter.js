import { Router } from 'express';
import { 
    getTotalOportunidade, 
    getPipelineByUnidade 
} from '../controllers/oportunidadeController.js';

const router = Router();

router.get('/pipeline', getPipelineByUnidade);
router.get('/total', getTotalOportunidade);

export default router;