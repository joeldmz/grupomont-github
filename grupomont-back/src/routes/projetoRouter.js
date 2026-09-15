import { Router } from 'express';
import { getDetalheProjeto, getMain, getProgressoMedio, getProjetos } from '../controllers/projetoController.js';
const router = Router();

router.get('/', getProjetos);
router.get('/main', getMain);
router.get('/detalhe', getDetalheProjeto);
router.get('/progresso', getProgressoMedio);


export default router;