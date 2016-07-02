module.exports = function () {
  this.When(/^I visit the Todos page$/, function () {
    return this.browser
      .goto(`${this.baseUrl}/`);
  });

  this.When(/^I create a Todo$/, function () {
    const todoText = 'Buy milk';
    this.ctx.todoText = todoText;
    const enter = '\u000d';
    return this.browser
      .type('#new-todo', todoText)
      .type('#new-todo', enter);
  });
};
