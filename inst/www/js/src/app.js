import { Locker } from './rlocker.js';

/* @namespace: rlocker */
var rlocker = rlocker || {};

/* @config */
Shiny.addCustomMessageHandler('rlocker-setup', function(config) {
  rlocker = new Locker(config);
});

Shiny.addCustomMessageHandler('rlocker-store', function(values) {
  let statement = rlocker.createStatement(values);
  rlocker.store(statement);
});

Shiny.addCustomMessageHandler('create-statement', function(values) {
  let statement = rlocker.createBasicStatement(values.verb.display['en-US']);
  rlocker.store(statement);
});