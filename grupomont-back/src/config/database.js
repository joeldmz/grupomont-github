import pg from 'pg';
import dotenv from 'dotenv';

dotenv.config();

const { Pool } = pg;

const pool = new Pool({
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT || '5432'),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

pool.on('error', (err) => {
  console.error('Error inesperado en el pool de PG', err);
  process.exit(-1);
});

export const testConnection = async () => {
  try {
    const client = await pool.connect();
    console.log('Conexión a PostgreSQL exitosa');
    client.release();
    return true;
  } catch (error) {
    console.error('Error conectando a PostgreSQL:', error.message);
    return false;
  }
};

export const dbquery = (text, params) => pool.query(text, params);
export const getClient = () => pool.connect();

export default pool;