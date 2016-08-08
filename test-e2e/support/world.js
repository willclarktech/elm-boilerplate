// @flow
import Browser from 'nightmare';
import chai from 'chai';
import chaiAsPromised from 'chai-as-promised';

import { TodosPage } from '../page-objects';

require('../../scripts/pretty-error');
global.Promise = require('bluebird');
chai.use(chaiAsPromised);

function World(): void {
  this.expect = chai.expect;
}

function Before(): void {
  this.browser = Browser({
    waitTimeout: 2000,
  });
  this.browser.ctx = {};
  this.browser.baseUrl = 'http://localhost:3000';

  this.todosPage = new TodosPage({
    browser: this.browser,
  });
}

module.exports = function createWorld(): void {
  this.World = World;
  this.Before(Before);
};
