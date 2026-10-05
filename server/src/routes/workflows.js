import {Router} from 'express';import {pool} from '../db/db.js';const router=Router();
router.get('/',async(req,res,next)=>{try{const [r]=await pool.query('SELECT * FROM workflows ORDER BY id');res.json(r)}catch(e){next(e)}});
router.patch('/:id/toggle',async(req,res,next)=>{try{await pool.query('UPDATE workflows SET enabled=NOT enabled WHERE id=?',[req.params.id]);const [[r]]=await pool.query('SELECT * FROM workflows WHERE id=?',[req.params.id]);res.json(r)}catch(e){next(e)}});
router.get('/templates',async(req,res,next)=>{try{const [r]=await pool.query('SELECT * FROM message_templates ORDER BY id');res.json(r)}catch(e){next(e)}});
router.patch('/templates/:id',async(req,res,next)=>{try{await pool.query('UPDATE message_templates SET subject=?,body=? WHERE id=?',[req.body.subject,req.body.body,req.params.id]);const [[r]]=await pool.query('SELECT * FROM message_templates WHERE id=?',[req.params.id]);res.json(r)}catch(e){next(e)}});
export default router;
