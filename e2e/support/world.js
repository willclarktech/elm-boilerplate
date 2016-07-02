const Browser = require('zombie');
Browser.prototype.keyUp = function (targetSelector, keyCode) {
  const event = this.window.document.createEvent('HTMLEvents');
  event.initEvent('keyup', true, true);
  event.which = keyCode;
  const target = this.window.document.querySelector(targetSelector);
  if (target) { target.dispatchEvent(event); }
  return this;
};
Browser.localhost('example.com', 3000);

function World() {
  this.browser = new Browser();
  this.ctx = {};
}

module.exports = function createWorld() {
  this.World = World;
};
