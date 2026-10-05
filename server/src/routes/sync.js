import {Router} from 'express';import {pool} from '../db/db.js';const router=Router();
router.get('/last',async(req,res,next)=>{try{const [[r]]=await pool.query("SELECT * FROM sync_log WHERE status='completed' ORDER BY synced_at DESC LIMIT 1");res.json(r||null)}catch(e){next(e)}});
router.post('/',async(req,res,next)=>{try{const [r]=await pool.query("INSERT INTO sync_log(customers_synced,orders_synced,products_synced,status) VALUES(?,?,?,'completed')",[128,342,86]);const [[row]]=await pool.query('SELECT * FROM sync_log WHERE id=?',[r.insertId]);res.json({...row,simulated:true})}catch(e){next(e)}});
export default router;
