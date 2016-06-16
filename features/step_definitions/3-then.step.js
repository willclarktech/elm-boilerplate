module.exports = function thenSteps() {
  this.Then(/^The page should load$/, function () {
    return this.browser.assert.success();
  });

  this.Then(/^There should be some content$/, function () {
    return this.browser.assert.text('h1', 'Example App');
  });

  this.Then(/^my account balance should be \$(\d+)$/, function (expectedBalance) {
    return this.browser.assert.text('.account-summary .balance', expectedBalance);
  });
};
