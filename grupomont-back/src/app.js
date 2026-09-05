import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import userRoutes from './routes/userRoutes.js';
import overviewRoutes from './routes/overviewRoutes.js';
import leadRoutes from './routes/leadRoutes.js';
import campanhaRoutes from './routes/campanhaRouter.js';
import oportunidadeRoutes from './routes/oportunidadeRouter.js';
import funilRoutes from './routes/funilRouter.js'

const app = express();

app.use(helmet());
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/api/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// app.use('/api/users', userRoutes);
app.use('/api/overview', overviewRoutes);
app.use('/api/leads', leadRoutes);
app.use('/api/campanha', campanhaRoutes);
app.use('/api/oportunidade', oportunidadeRoutes);
app.use('/api/funil', funilRoutes);

app.use((req, res) => {
  res.status(404).json({ error: 'Ruta no encontrada' });
});

app.use((err, req, res, next) => {
  console.error(err.stack);
  const status = err.status || 500;
  res.status(status).json({
    error: err.message || 'Error interno del servidor',
    ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
  });
});

export default app;