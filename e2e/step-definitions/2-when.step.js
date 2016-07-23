module.exports = function () {
  this.When(/^I visit the Todos page$/, function () {
    return this.todosPage.visit();
  });

  this.When(/^I create a Todo$/, function () {
    return this.todosPage.createTodo();
  });

  this.When(/^I complete the Todo$/, function () {
    return this.todosPage.completeTodo();
  });
};
