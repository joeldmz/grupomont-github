import { Router } from 'express';
import { 
    getReceita, 
    getReceitaByUnidade, 
    getTaixaConversao, 
    getOportunidadePipeline , 
    getResultadosGerados,
    getMarketingPerformance
} from '../controllers/overviewController.js';

const router = Router();

router.get('/receita', getReceita);
router.get('/receita/unidade', getReceitaByUnidade);
router.get('/conversao', getTaixaConversao);
router.get('/pipeline', getOportunidadePipeline);
router.get('/resultados', getResultadosGerados)
router.get('/marketing/performance', getMarketingPerformance)

export default router;