import { Router } from 'express';
import { 
    getLeads,
    getTotalLead
} from '../controllers/leadController.js';

const router = Router();

router.get('/', getLeads);
router.get('/total', getTotalLead);

export default router;