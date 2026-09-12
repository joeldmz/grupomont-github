import { Router } from 'express';
import { getDetalheProjeto, getMain, getProjetos } from '../controllers/projetoController.js';
const router = Router();

router.get('/', getProjetos);
router.get('/main', getMain);
router.get('/detalhe', getDetalheProjeto);

export default router;