import BasePage from './Base.page';

const COMPLETED_CLASS = 'completed';

export default class TodosPage extends BasePage {
  constructor({ browser }) {
    const path = '/';
    const identifier = 'h1';

    super({
      browser,
      path,
      identifier,
    });

    this.selectors = {
      identifier,
      newTodo: '#new-todo',
      toggleTodo: '.toggle',
      deleteTodo: '.delete',
      todo: 'li',
      todoText: 'li label',
    };
  }

  createTodo(text) {
    const todoText = typeof text === 'string'
      ? text
      : 'Test';
    this.browser.ctx.todoText = todoText;
    return this
      .typeTextIntoElementAndSubmit(todoText, this.selectors.newTodo);
  }

  markTodoAsComplete() {
    return this
      .clickElement(this.selectors.toggleTodo);
  }

  markTodoAsIncomplete() {
    return this
      .clickElement(this.selectors.toggleTodo);
  }

  deleteTodo() {
    return this
      .clickElement(this.selectors.deleteTodo);
  }

  isTodoPresent() {
    return this
      .getElementText(this.selectors.todoText)
      .then(text => text === this.browser.ctx.todoText)
      .catch(() => false);
  }

  isTodoCompleted() {
    return this
      .getClassList(this.selectors.todo)
      .then(classList => classList.includes(COMPLETED_CLASS));
  }
}
