import { Router } from 'express';
import { 
    getTotalOportunidade, 
    getPipelineByUnidade, 
    getOportunidadeByEquipe
} from '../controllers/oportunidadeController.js';

const router = Router();

router.get('/pipeline', getPipelineByUnidade);
router.get('/total', getTotalOportunidade);
router.get('/equipe', getOportunidadeByEquipe);

export default router;