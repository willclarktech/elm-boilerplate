import { todos } from '../../../fixtures';

export default function givenSteps() {
  this.Given(/^I am on the Todos page$/, function () {
    return this.todosPage.visit();
  });

  this.Given(/^I have created a todo with text "([^"]*)"$/, function (todoText) {
    this.browser.ctx.todoText = todoText;
    return this.todosPage.createTodoWithText(todoText);
  });

  this.Given(/^I have created (\d+) Todos$/, function (n) {
    const numberOfTodos = parseInt(n, 10);
    const todoTexts = todos
      .slice(0, numberOfTodos)
      .map(({ text }) => text);

    this.browser.ctx.todoTexts = todoTexts;
    return this.todosPage.createTodos(todoTexts);
  });

  this.Given(/^I have marked the todo as complete$/, function () {
    return this.todosPage.markTodoAsComplete();
  });

  this.Given(/^I have completed (\d+) Todos$/, function (numberOfTodos) {
    const todoTexts = [...this.browser.ctx.todoTexts];
    if (numberOfTodos > todoTexts.length) {
      throw new Error(`You are trying to complete ${numberOfTodos} todos but there are only ${todoTexts.length}!`);
    }

    const completedIndices = [];

    const completeRandomTodos = (incompleteTodos, numberToComplete, completedTodos = []) => {
      if (numberToComplete > completedTodos.length) {
        const index = parseInt(Math.random() * incompleteTodos.length, 10);
        const todoToComplete = incompleteTodos[index];
        completedIndices.push(todoTexts.indexOf(todoToComplete));
        const newCompleteTodos = [...completedTodos, todoToComplete];
        const newIncompleteTodos = incompleteTodos.filter((todo, i) => i !== index);
        return completeRandomTodos(newIncompleteTodos, numberToComplete, newCompleteTodos);
      }
      return { completedTodos, incompleteTodos };
    };

    const { completedTodos, incompleteTodos } = completeRandomTodos(todoTexts, numberOfTodos);
    this.browser.ctx.completedTodos = completedTodos;
    this.browser.ctx.incompleteTodos = incompleteTodos;

    return this.todosPage.markTodosAsComplete(completedIndices);
  });

  this.Given(/^I have filtered for completed Todos$/, function () {
    return this.todosPage.filter('completed');
  });
}
