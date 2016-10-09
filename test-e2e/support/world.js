import Browser from 'nightmare';
import Bluebird from 'bluebird';
import chai from 'chai';
import chaiAsPromised from 'chai-as-promised';
import * as pageObjects from '../page-objects';

require('../../scripts/pretty-error');
require('babel-runtime/core-js/promise').default = Bluebird;

chai.use(chaiAsPromised);

function World() {
  this.expect = chai.expect;
}

function Before() {
  this.browser = Browser({
    waitTimeout: 2e3,
    webPreferences: { partition: 'test' }, // Store session in memory
    // show: true,
  });
  this.browser.ctx = {};
  this.browser.baseUrl = 'http://localhost:3000';

  for (const [key, PageObject] of Object.entries(pageObjects)) {
    this[key] = new PageObject({ browser: this.browser });
  }
}

export default function createWorld() {
  this.setDefaultTimeout(15e3);
  this.World = World;
  this.Before(Before);
}
