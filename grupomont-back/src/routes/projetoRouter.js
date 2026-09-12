import { Router } from 'express';
import { getDetalheProjeto, getMainKpis, getProjetos } from '../controllers/projetoController.js';
const router = Router();

router.get('/', getProjetos);
router.get('/main', getMainKpis);
router.get('/detalhe', getDetalheProjeto);

export default router;