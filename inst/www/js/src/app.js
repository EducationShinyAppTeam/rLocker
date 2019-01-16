import { Locker } from './rlocker.js';

/* @namespace: rlocker */
var rlocker = rlocker || {};
 
/* @config */
Shiny.addCustomMessageHandler('rlocker-setup', function(config) {
  rlocker = new Locker(config);
});

Shiny.addCustomMessageHandler('create-statement', function(statement) {
  let request = rlocker.createBasicStatement(statement.verb.display['en-US']);
  rlocker.store(request);
});