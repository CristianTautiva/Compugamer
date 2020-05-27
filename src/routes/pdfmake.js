const express = require('express');
const router = express.Router();
const LocalStorage = require('node-localstorage').LocalStorage,
localStorage = new LocalStorage('./scratch');
const pool = require('../databases');
var pdfMake = require('pdfmake/build/pdfmake.js');
var pdfFonts = require('pdfmake/build/vfs_fonts.js');
pdfMake.vfs = pdfFonts.pdfMake.vfs;
const uuid = require('uuid').v4;
const {createCanvas, loadImage} = require('canvas');
function getImage(url, size) {
    return loadImage(url).then(image => {
        const canvas = createCanvas(size, size);
        let ctx = canvas.getContext('2d');
        ctx.drawImage(image, 0, 0);
        return canvas.toDataURL();
    });
}




router.post('/pdf', async (req, res, next) => {
    //res.send('pdf');
    const vendedor = req.body.vendedor;
    var carrito = '0';
    //recorriendo el storage para ver si hay computadores agregados para listar
    for (let x = 0; x < localStorage.length; x++) {
        carrito += (localStorage.key(x)) + ",";
    }
    //formateamos el string carrito quitando la ultima ','
    carrito = carrito.slice(0, -1);
    //si carrito esta vacio, ponemos el valor de cero para que la consulta no se totee
    if ((carrito == '')) {
        carrito = '0';
    }

    let pc = {};
    //seleccionando todos los pc que esten en el carrito de ventas
    let query = 'SELECT * FROM computador WHERE id IN (' + carrito + ')';

    pc = await pool.query(query);
    // poniendo el tipo de pc que es de acuerdo a su id
    for (let clave in pc) {
        // 
        if (pc.hasOwnProperty(clave)) {
            let tipo = await pool.query('SELECT tipo_desc FROM tipo_computador WHERE tipo_id = ?', [pc[clave].comp_tipo]);

            pc[clave].comp_tipo = tipo[0].tipo_desc;

        }
    }

    const imageData = await getImage('https://res.cloudinary.com/dcris/image/upload/v1589815418/logo_xjpifl.png', 752);
    var documentDefinition = {
        content: [
            {
                image: 'data:image/jpeg,'+imageData,
                width: 120,
                height: 120,
            },
            {
              layout: 'lightHorizontalLines', // optional
              table: {
                // headers are automatically repeated if the table spans over multiple pages
                // you can declare how many rows should be treated as headers
                headerRows: 1,
                widths: [ '*', 'auto', 100, '*' ],
        
                body: [
                  [ { text: 'Fecha', bold: true }, { text: 'Descripcion', bold: true }, { text: 'Precio Unitario', bold: true }, { text: 'Cantidad', bold: true } ],
                  [ vendedor, 'Value 2', 'Value 3', 'Value 4' ],
                  [ { text: 'Bold value', bold: true }, 'Val 2', 'Val 3', 'Val 4' ]
                ]
              }
            }
          ]         
}


    const codigoFactura = uuid();
    const pdfDoc = pdfMake.createPdf(documentDefinition);
    
    pdfDoc.getBase64((data) => {
        res.writeHead(200,
            {
                'Content-Type': 'application/pdf',
                'Content-Disposition': 'attachment;filename="'+codigoFactura+'".pdf'
            });
        const download = Buffer.from(data.toString('utf-8'), 'base64');
        
        res.end(download);
    });
    
});



module.exports = router;