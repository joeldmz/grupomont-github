import { Router } from 'express';
import { 
    getTotalOportunidade, 
    getPipelineByUnidade, 
    getOportunidadeByEquipe,
    getOportunidadeAndEtapa
} from '../controllers/oportunidadeController.js';

const router = Router();

router.get('/pipeline', getPipelineByUnidade);
router.get('/total', getTotalOportunidade);
router.get('/equipe', getOportunidadeByEquipe);
router.get('/etapa', getOportunidadeAndEtapa);

export default router;