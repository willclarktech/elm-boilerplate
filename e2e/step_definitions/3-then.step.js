module.exports = function thenSteps() {
  this.Then(/^The page should load$/, function () {
    return this.browser.assert.success();
  });

  this.Then(/^There should be some content$/, function () {
    return this.browser.assert.text('h1', 'Example App');
  });

  this.Then(/^I should see the Todo$/, function () {
    return this.browser.assert.text('li label', this.ctx.todoText);
  });
};
