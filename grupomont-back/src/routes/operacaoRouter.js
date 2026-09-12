import { Router } from 'express';
import { getMainData, getOperacaoByCliente, getOperacoes } from '../controllers/operacaoController.js';

const router = Router();

router.get('/', getOperacoes);
router.get('/main', getMainData);
router.get('/cliente', getOperacaoByCliente);

export default router;