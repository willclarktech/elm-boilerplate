const Browser = require('zombie');
Browser.localhost('example.com', 3000);

function World() {
  this.browser = new Browser();
}

module.exports = function createWorld() {
  this.World = World;
};
