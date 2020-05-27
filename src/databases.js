const mysql = require('mysql');
const { database } = require('./keys');
const { promisify } = require ('util');

const pool = mysql.createPool(database);
 pool.getConnection((err,connection)=>{
     if(err){
         if(err.code === 'PROTOCOL_CONNECTION_LOST' ){
            console.error('Database Connection Was Closed');
         }
         if(err.code === 'ER_CON_COUNT_ERROR'){
            console.error('Database Has To Many Connections'); 
         }
         if(err.code === 'ECONNREFUSED'){
            console.error('Database Connection was Refused'); 
         }
     }
     if(connection) connection.release();
     console.log('Database is Connected')
     return;
 });
//Promisify Pool Query
 pool.query = promisify(pool.query);
 module.exports = pool;