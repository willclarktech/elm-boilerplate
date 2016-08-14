module.exports = function whenSteps() {
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

  this.When(/^I filter for (completed|incomplete|all) Todos$/, function (filterOption) {
    return this.todosPage.filter(filterOption);
  });

  this.When(/^I edit the Todo$/, function () {
    return this.todosPage.editTodo();
  });

  this.When(/^I log in with Facebook$/, function () {
    const { email, password } = this.browser.ctx.user;
    return this.todosPage.login()
      .then(() => this.facebookLoginPage.login(email, password));
  });
};
