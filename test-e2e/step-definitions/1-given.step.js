module.exports = function givenSteps() {
  this.Given(/^I am on the Todos page$/, function () {
    return this.todosPage.visit();
  });

  this.Given(/^I have created a todo$/, function () {
    return this.todosPage.createTodo();
  });

  this.Given(/^I have created (\d+) Todos$/, function (numberOfTodos) {
    return this.todosPage.createTodos(numberOfTodos);
  });

  this.Given(/^I have marked the todo as complete$/, function () {
    return this.todosPage.markTodoAsComplete();
  });

  this.Given(/^I have completed (\d+) Todos$/, function (numberOfTodos) {
    return this.todosPage.markTodosAsComplete(numberOfTodos);
  });

  this.Given(/^I have filtered for completed Todos$/, function () {
    return this.todosPage.filter('completed');
  });

  this.Given(/^I have a Facebook account$/, function (callback) {
    this.browser.ctx.user = {
      name: 'Testy McTestface',
      email: 'testy_srtiwyc_mctestface@tfbnw.net',
      password: 'testing123',
    };
    callback();
  });
};
