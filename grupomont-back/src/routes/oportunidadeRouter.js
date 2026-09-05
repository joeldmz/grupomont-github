import { Router } from 'express';
import {  getOportunidade, getTotalOportunidade, getOportunidadeByUnidade } from '../controllers/oportunidadeController.js';

const router = Router();

router.get('/', getOportunidade);
router.get('/total', getTotalOportunidade);
router.get('/unidade', getOportunidadeByUnidade)

export default router;