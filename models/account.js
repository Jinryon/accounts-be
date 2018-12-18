/**
  * models/account.js
  */

//Global declaration
//TODO Why export is not handled such as in other files ?
'use strict';
const db = require('../common/db');


let get = async (req, res) => {
  const text = 'SELECT * FROM t_acc_accounts WHERE acc_uuid = $1';
console.log('TEST');
console.log(req.params.id);
  try {
    const { rows } = await db.query(text, [req.params.id]);
    if (!rows[0]) {
console.log('NOT FOUND');
      return res.status(404).send({'message': 'reflection not found'});
    }
console.log('FOUND');
    return res.status(200).send(rows[0]);
  } catch(error) {
console.log('ERROR');
console.log(error);
    //return res.status(400).send(error);
    res.send('ERROR ' + error.stack);
  }
}


//Export
module.exports={
  get : get
};
