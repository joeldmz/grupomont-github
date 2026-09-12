import dotenv from 'dotenv';
import app from './app.js';
import { testConnection } from './config/database.js';

dotenv.config();

const PORT = process.env.PORT || 3000;

const startServer = async () => {
  const dbConnected = await testConnection();

  if (!dbConnected) {
    console.error('🛑 No se pudo conectar a la base de datos. Apagando...');
    process.exit(1);
  }

  const server = app.listen(PORT, '0.0.0.0',() => {
    console.log(`🚀 Servidor corriendo en http://localhost:${PORT}`);
    console.log(`📝 Entorno: ${process.env.NODE_ENV}`);
  });

  const shutdown = () => {
    console.log('\n🛑 Apagando servidor...');
    server.close(() => {
      console.log('✅ Servidor HTTP cerrado.');
      process.exit(0);
    });
    setTimeout(() => process.exit(1), 10000);
  };

  process.on('SIGTERM', shutdown);
  process.on('SIGINT', shutdown);
};

startServer();