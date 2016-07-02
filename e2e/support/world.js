import Browser from 'nightmare';
import chai from 'chai';
import chaiAsPromised from 'chai-as-promised';

chai.use(chaiAsPromised);

function World() {
  this.browser = Browser({

  });
  this.expect = chai.expect;
  this.baseUrl = 'http://localhost:3000';
  this.ctx = {};
}

module.exports = function createWorld() {
  this.World = World;
};
