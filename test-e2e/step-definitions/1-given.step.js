module.exports = function () {
  this.Given(/^I am on the Todos page$/, function () {
    return this.todosPage.visit();
  });

  this.Given(/^I have created a todo$/, function () {
    return this.todosPage.createTodo();
  });

  this.Given(/^I have created several Todos$/, function (callback) {
    // Write code here that turns the phrase above into concrete actions
    callback(null, 'pending');
  });

  this.Given(/^I have completed some but not all of my Todos$/, function (callback) {
    // Write code here that turns the phrase above into concrete actions
    callback(null, 'pending');
  });

  this.Given(/^I have marked the todo as complete$/, function () {
    return this.todosPage.markTodoAsComplete();
  });
};
