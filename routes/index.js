/*
 * routes/index.js
 */


/*
 * Declarations
 */
'use strict';
const
  router = require('express').Router()
;


/*
 * Routes
 */
//TODO Is it usefull ?
router.get('/welcome', (req, res) => {
  return res.status(200).send({'message': 'Welcome everybody'});
})


/*
 * Module exports
 */
 module.exports = router;
