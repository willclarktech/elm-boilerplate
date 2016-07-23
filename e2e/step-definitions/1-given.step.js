module.exports = function () {
  this.Given(/^I am on the Todos page$/, function () {
    return this.todosPage.visit();
  });

  this.Given(/^I have created a todo$/, function () {
    return this.todosPage.createTodo();
  });
};
