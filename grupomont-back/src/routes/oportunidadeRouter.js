import { Router } from 'express';
import { 
    getTotalOportunidade, 
    getPipelineByUnidade 
} from '../controllers/oportunidadeController.js';

const router = Router();

router.get('/pipeline', getPipelineByUnidade);//mantener
router.get('/total', getTotalOportunidade);// mantener

export default router;