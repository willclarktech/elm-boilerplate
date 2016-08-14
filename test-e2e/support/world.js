import Browser from 'nightmare';
import chai from 'chai';
import chaiAsPromised from 'chai-as-promised';

import { TodosPage, FacebookLoginPage } from '../page-objects';

require('../../scripts/pretty-error');
global.Promise = require('bluebird');
chai.use(chaiAsPromised);

function World() {
  this.expect = chai.expect;
}

function Before() {
  this.browser = Browser({
    waitTimeout: 2e3,
    // show: true,
  });
  this.browser.ctx = {};
  this.browser.baseUrl = 'http://localhost:3000';

  this.todosPage = new TodosPage({
    browser: this.browser,
  });
  this.facebookLoginPage = new FacebookLoginPage({
    browser: this.browser,
  });
}

module.exports = function createWorld() {
  this.setDefaultTimeout(5e3);
  this.World = World;
  this.Before(Before);
};
