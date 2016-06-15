module.exports = function thenSteps() {
  this.Then(/^The page should load$/, function () {
    return this.browser.assert.success();
  });

  this.Then(/^There should be some content$/, function () {
    return this.browser.assert.text('h1', 'Example App');
  });

  this.Then(/^my account balance should be \$(\d+)$/, function (arg1, callback) {
    // Write code here that turns the phrase above into concrete actions
    callback(null, 'pending');
  });
};
