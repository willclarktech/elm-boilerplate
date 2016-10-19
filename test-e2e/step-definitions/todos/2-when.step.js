export default function whenSteps() {
  this.When(/^I visit the Todos page$/, function () {
    return this.todosPage.visit();
  });

  this.When(/^I create a Todo with text "([^"]*)"$/, function (todoText) {
    this.browser.ctx.todoText = todoText;
    return this.todosPage.createTodoWithText(todoText);
  });

  this.When(/^I try to create a blank Todo$/, function () {
    return this.todosPage.createTodoWithText('');
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
    const newTodoText = 'Edited';
    this.browser.ctx.editedText = newTodoText;
    return this.todosPage.editTodo(newTodoText);
  });

  this.When(/^I visit the info route$/, function () {
    return this.todosPage.visitTab('info');
  });

  this.When(/^I save my Todos$/, function () {
    return this.todosPage.save();
  });

  this.When(/^I leave the site$/, function () {
    return this.browser.cookies.clearAll();
  });
}
