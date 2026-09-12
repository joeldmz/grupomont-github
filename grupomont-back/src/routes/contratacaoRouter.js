import { Router } from 'express';
import { getContratacaoByOperadora, getContratacaoByPlano, getContratacoesByPeriodo } from '../controllers/contratacaoController.js';

const router = Router();

router.get('/periodo', getContratacoesByPeriodo);
router.get('/operadora', getContratacaoByOperadora)
router.get('/plano', getContratacaoByPlano);

export default router;