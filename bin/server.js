/*
 * bin/server.js
 */


/*
 * Declarations
 */
'use strict';
const express = require('express'),
  app = express(),

  // Logging declaration
  morgan = require('morgan'),
  winston = require('../common/winston'),

  // Global variables
  gv = require('../config/config.json'),
  api_port = gv.listen_port,

  // Routes
  indexRoute = require('../routes/index'),
  accountRoutes = require('../routes/account'),

  // Backingstore
  db = require('../common/db')
  //TODO path = require('path'),
  //TODO bodyParser = require('body-parser'),
;


/*
 * Logging configuration
 */
app.use(morgan('combined', { stream: winston.stream }));


/*
 * Routes
 */
app.use('/', indexRoute);
app.use('/account/', accountRoutes);


/*
 * Server startup
 */
winston.info('Starting nodeJS server...');
db.connect();
app.listen(api_port);
winston.info('NodeJS server successfully started');

