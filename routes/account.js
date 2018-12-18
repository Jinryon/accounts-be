/*
 * routes/account.js
 */


/*
 * Declarations
 */
'use strict';
const
  router = require('express').Router(),
  accountController = require('../controllers/account')
;

/*
 * Routes
 */
//TODO handle errors on non existing paths
router.get('/list', accountController.list);
router.get('/get/:id', accountController.get); //Access via req.params.id


/*
 * Module exports
 */
module.exports = router;
