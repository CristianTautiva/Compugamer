const express = require('express');
const router = express.Router();
const pool = require('../databases');


router.get('/add_ref/:id',async (req,res)=>{
    let id = req.params.id;
    const pc = await pool.query('SELECT * FROM computador WHERE id = ?', [id]);
    res.render('references/ref', { pc: pc[0] });

});

router.post('/add_ref/:id',async (req,res)=>{
let id_us = req.user.id;
let id_comp = req.params.id;
let comment = req.body.reference;
const newComment = {
    id_user: id_us,
    comentario: comment,
    id_pc: id_comp
};


await pool.query('INSERT INTO comentarios set ?', [newComment]);
req.flash('success', 'Referencia agregada correctamente');
let tipo = await pool.query('SELECT * FROM computador WHERE id = ?', [newComment.id_pc]);
console.log(tipo[0].comp_tipo);
if (tipo[0].comp_tipo == 1) {
    res.redirect('/links/desktop');
} else if (tipo[0].comp_tipo == 2) {
    res.redirect('/links/laptop');
} else if (tipo[0].comp_tipo == 3) {
    res.redirect('/links/allinone');
}


      
});

router.get('/ref_of_users/:id', async(req,res)=>{
    let id = req.params.id;
    let user='';
    let pc1 = await pool.query('SELECT * FROM computador WHERE id = ?', [id]);
    let comment = await pool.query('SELECT * FROM comentarios WHERE id_pc = ?', [id]);
    let data = {  datos:[{
        id: '',
        comp_marca: '',
        comp_ref: '',
        image_url:''
      }],
      comment:[]       
      };
data.datos[0].id = pc1[0].id; 
data.datos[0].comp_marca = pc1[0].comp_marca;
data.datos[0].comp_ref = pc1[0].comp_ref;
data.datos[0].image_url = pc1[0].image_url;
data.comment = comment;


    for (var clave in data.comment) {
        if (data.comment.hasOwnProperty(clave)) {
            user =  await pool.query('SELECT * FROM cliente WHERE id = ?', [data.comment[clave].id_user]); 
            data.comment[clave].username = user[0].clie_nomb;
            data.comment[clave].user_img = user[0].profile_img;
        
        }
    }
    console.log(data);
    res.render('references/show_ref',  data );



        

});





module.exports = router;