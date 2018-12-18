/*
 * common/db.js
 */


 /*
  * Declarations
  */
'use strict';

const
  Pool = require('pg').Pool,
  winston = require('../common/winston')
;


/*
 * Connections parameters
 */
const gv_db  = require('../config/config.json').db;
const pool = new Pool({
  host: gv_db.host,
  port: gv_db.port,
  database: gv_db.instance,
  user: gv_db.username,
  password: gv_db.password,
});


/*
 * Connection function
 */
function connect() {
  try {
//TODO add config info
    winston.debug('Connecting to datase...');
    pool.connect();
    winston.debug('Connected to database');
  }
  catch(error){
//TODO add config info
    winston.alert('An error occured while connecting to database - ' + error.stack);
    winston.alert('Shutdowning server cause of database connection error');
    process.exit(1);
  }
}


/*
 * Query function
 */
//TODO add logs
//TODO add errors handler
const query = async (text, params) => {
  return new Promise((resolve, reject) => {
    pool.query(text, params)
      .then((res) => {
        resolve(res);
      })
      .catch((err) => {
        reject(err);
      })
  })
}


/*
 * Module exports
 */
module.exports = {
  query : query,
  connect : connect
};