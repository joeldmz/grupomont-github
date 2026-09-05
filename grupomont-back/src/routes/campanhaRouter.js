import { Router } from 'express';
import {  getCampanha, getCampanhaById, getInvestimento, getResultadoByCanal } from '../controllers/campanhaController.js';

const router = Router();

router.get('/', getCampanha);
router.get('/info', getCampanhaById);
router.get('/investimento', getInvestimento);
router.get('/canal', getResultadoByCanal);

export default router;