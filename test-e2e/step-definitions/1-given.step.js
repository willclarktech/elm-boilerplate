module.exports = function givenSteps(): void {
  this.Given(/^I am on the Todos page$/, function (): bool {
    return this.todosPage.visit();
  });

  this.Given(/^I have created a todo$/, function (): bool {
    return this.todosPage.createTodo();
  });

  this.Given(/^I have created (\d+) Todos$/, function (numberOfTodos): bool {
    return this.todosPage.createTodos(numberOfTodos);
  });

  this.Given(/^I have marked the todo as complete$/, function (): bool {
    return this.todosPage.markTodoAsComplete();
  });

  this.Given(/^I have completed (\d+) Todos$/, function (numberOfTodos): bool {
    return this.todosPage.markTodosAsComplete(numberOfTodos);
  });

  this.Given(/^I have filtered for completed Todos$/, function (): bool {
    return this.todosPage.filter('completed');
  });
};
