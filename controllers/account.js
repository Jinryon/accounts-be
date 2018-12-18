/*
 * bin/server.js
 */


/*
 * Declarations
 */
'use strict';
const accountModel = require('../models/account');

//TODO Why the export is not managed such as other JS files ??
exports.list = function(req, res) {
    res.send('NOT IMPLEMENTED: Account list');
};

exports.get = async function(req, res) {
console.log('IN controller');
  //res.send(accountModel.get(req, res));
console.log(accountModel.get(req, res));
};

