module.exports = function () {
  this.Given(/^I am on the Todos page$/, function () {
    return this.browser
      .goto(`${this.baseUrl}/`);
  });

  this.Given(/^I have created a todo$/, function () {
    const todoText = 'Buy milk';
    this.ctx.todoText = todoText;
    const enter = '\u000d';
    return this.browser
      .type('#new-todo', todoText)
      .type('#new-todo', enter);
  });
};
