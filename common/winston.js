/*
 * common/winston.js
 */


 /*
  * Declarations
  */
'use strict';
const winston = require('winston');

//TODO Push conf in a JSON file
const options = {
  file: {
    level: 'info',
    filename: `/data/dev/accounts-nodejs/logs/app.log`,
    handleExceptions: true,
    json: true,
    maxsize: 5242880, // 5MB
    maxFiles: 5,
    colorize: false,
  },
  console: {
    level: 'debug',
    handleExceptions: true,
    json: false,
    colorize: true,
  },
};


/*
 * Logger functions
 */
const logger = winston.createLogger({
  transports: [
    new winston.transports.File(options.file),
    new winston.transports.Console(options.console)
  ],
  exitOnError: false, // Do not exit on handled exceptions
});

logger.stream = {
  write: function(message, encoding) {
    logger.info(message); //TODO to analyse
  },
};


/*
 * Module exports
 */
module.exports = logger;