const express = require('express');
const router = express.Router();
const pool = require('../databases');
const { isLoggedIn } = require('../lib/protectLinks');

router.get('/buscar', isLoggedIn, async (req, res) => {

    var dato = req.query.dato;
    dato = dato.toLowerCase();
    const typeConsult = ['comp_proc', 'comp_ram', 'comp_alm'];
    var pc = {};

    try {
        pc = await pool.query('SELECT * FROM computador WHERE comp_marca = ?', [dato]);
        
    } catch (error) {
        //nada
    }
    //si no se encontro un pc por marca, significa que se esta buscando por otro tipo de consulta, puede ser por procesador, ram o almacenamiento

    if (Object.keys(pc).length === 0) {
        //buscamos por referencia o por marca y referencia respectivamente
        try {
            let arreglo = dato.split(" ");

            pc = await pool.query('SELECT * FROM computador WHERE comp_ref = ?', [arreglo[1]]);
            
        } catch (error) {
            //nada
        }
    }
    if (Object.keys(pc).length === 0) {
       // si en esta instancia no hemos encontrado un producto, recorremos el array de tipo consulta para hacer las consultas por ram , procesador y alm.
        for (var i = 0; i < typeConsult.length; i++) {
            
            if (Object.keys(pc).length === 0) {

                var sql = 'SELECT * FROM computador WHERE ' + typeConsult[i] + ' = ?';
                pc = await pool.query(sql, [dato]);
                
            }
        }

    }
    // al final devolvemos el pc encontrado.
    res.render('links/list', { pc });

});

router.get('/search_for_shopping',async (req,res)=>{
    var dato = req.query.dato;
    dato = dato.toLowerCase();
    const typeConsult = ['comp_proc', 'comp_ram', 'comp_alm'];
    var pc = {};

    try {
        pc = await pool.query('SELECT * FROM computador WHERE comp_marca = ?', [dato]);
        
    } catch (error) {
        //nada
    }

    if (Object.keys(pc).length === 0) {
        try {
            let arreglo = dato.split(" ");

            console.log('entre');
            pc = await pool.query('SELECT * FROM computador WHERE comp_ref = ?', [arreglo[1]]);
            
        } catch (error) {
            //nada
        }
    }
    if (Object.keys(pc).length === 0) {

        for (var i = 0; i < typeConsult.length; i++) {
            
            if (Object.keys(pc).length === 0) {

                var sql = 'SELECT * FROM computador WHERE ' + typeConsult[i] + ' = ?';
                pc = await pool.query(sql, [dato]);
                
            }
        }
    }
    res.render('links/registrar_venta',{ pc });
});

module.exports = router;