module.exports = function () {
  this.When(/^I visit the homepage$/, function () {
    return this.browser.visit('/');
  });

  this.When(/^I visit the Todos page$/, function () {
    return this.browser
      .visit('/');
  });

  this.When(/^I create a Todo$/, function () {
    const todoText = 'Buy milk';
    this.ctx.todoText = todoText;
    return this.browser
      .fill('#new-todo', todoText)
      .keyUp('#new-todo', 13);
  });
};
