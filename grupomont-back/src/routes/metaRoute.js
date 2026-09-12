import { Router } from 'express';
import { getMetas } from '../controllers/metaController.js';
const router = Router();

router.get('/', getMetas);

export default router;