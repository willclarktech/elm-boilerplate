module.exports = function () {
  this.When(/^I visit the Todos page$/, function () {
    return this.todosPage.visit();
  });

  this.When(/^I create a Todo$/, function () {
    return this.todosPage.createTodo();
  });

  this.When(/^I try to create a blank Todo$/, function () {
    return this.todosPage.createTodo('');
  });

  this.When(/^I mark the Todo as complete$/, function () {
    return this.todosPage.markTodoAsComplete();
  });

  this.When(/^I mark the Todo as incomplete$/, function () {
    return this.todosPage.markTodoAsIncomplete();
  });

  this.When(/^I delete the Todo$/, function () {
    return this.todosPage.deleteTodo();
  });

  this.When(/^I filter for completed Todos$/, function (callback) {
    // Write code here that turns the phrase above into concrete actions
    callback(null, 'pending');
  });

  this.When(/^I filter for incomplete Todos$/, function (callback) {
    // Write code here that turns the phrase above into concrete actions
    callback(null, 'pending');
  });
};
