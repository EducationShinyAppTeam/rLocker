import { Locker } from './rLocker.js';

/* @namespace: rLocker */
var rLocker = rLocker || {};

/* @config */
Shiny.addCustomMessageHandler('rlocker-setup', function(config) {
  rLocker = new Locker(config);
});

Shiny.addCustomMessageHandler('rlocker-store', function(values) {
  let statement = rLocker.createStatement(values);
  rLocker.store(statement);
});

Shiny.addCustomMessageHandler('create-statement', function(values) {
  let statement = rLocker.createBasicStatement(values.verb.display['en-US']);
  rLocker.store(statement);
});
