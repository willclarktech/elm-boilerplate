import Browser from 'nightmare';
import chai from 'chai';
import chaiAsPromised from 'chai-as-promised';

import { TodosPage } from '../page-objects';

global.Promise = require('bluebird');
chai.use(chaiAsPromised);

function World() {
  this.browser = Browser({
    waitTimeout: 1000,
  });
  this.browser.ctx = {};
  this.browser.baseUrl = 'http://localhost:3000';

  this.todosPage = new TodosPage({
    browser: this.browser,
  });

  this.expect = chai.expect;
}

module.exports = function createWorld() {
  this.World = World;
};
