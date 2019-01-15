import { Locker } from './rlocker.js';

/* @namespace: rlocker */
var rlocker = rlocker || {};
 
/* @config */
Shiny.addCustomMessageHandler('rlocker-setup', function(config) {
  rlocker = new Locker(config);
  console.warn('Alerted');
});