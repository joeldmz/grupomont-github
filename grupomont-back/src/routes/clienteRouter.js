import { Router } from 'express';
import { getClientes, getTotalClientes } from '../controllers/clienteController.js';

const router = Router();

router.get('/total', getTotalClientes);
router.get('/', getClientes);

export default router;