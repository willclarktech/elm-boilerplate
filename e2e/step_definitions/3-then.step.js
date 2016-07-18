function getText(selector) {
  return document.querySelector(selector).innerText;
}

function getClassList(selector) {
  const className = document
    .querySelector(selector)
    .getAttribute('class');
  return className
    ? className.split(' ')
    : [];
}

module.exports = function thenSteps() {
  this.Then(/^The page should load$/, function () {
    return this.browser.assert.success();
  });

  this.Then(/^There should be some content$/, function () {
    const expectedText = 'Example App';
    const selector = 'h1';
    const result = this.browser
      .wait(selector)
      .evaluate(getText, selector);
    return this.expect(result)
      .eventually.to.equal(expectedText);
  });

  this.Then(/^I should see the Todo$/, function () {
    const selector = 'li label';
    const result = this.browser
      .wait(selector)
      .evaluate(getText, selector);
    return this.expect(result)
      .eventually.to.equal(this.ctx.todoText);
  });

  this.Then(/^I should see that the Todo is completed$/, function () {
    const selector = 'li';
    const result = this.browser
      .wait(selector)
      .evaluate(getClassList, selector);
    return this.expect(result)
      .eventually.to.include('completed');
  });
};
