import express from 'express';import cors from 'cors';import dotenv from 'dotenv';
import customers from './routes/customers.js';import orders from './routes/orders.js';import workflows from './routes/workflows.js';import dashboard from './routes/dashboard.js';import sync from './routes/sync.js';import analytics from './routes/analytics.js';import {errorHandler} from './middleware/error.js';
dotenv.config();const app=express();app.use(cors({origin:process.env.CLIENT_URL||'http://localhost:5173'}));app.use(express.json());
app.get('/api/health',(req,res)=>res.json({ok:true,service:'CherryCRM API'}));
app.use('/api/customers',customers);app.use('/api/orders',orders);app.use('/api/workflows',workflows);app.use('/api/dashboard',dashboard);app.use('/api/sync',sync);app.use('/api/analytics',analytics);app.use(errorHandler);
const port=Number(process.env.PORT||8080);app.listen(port,()=>console.log(`CherryCRM API running on http://localhost:${port}`));
