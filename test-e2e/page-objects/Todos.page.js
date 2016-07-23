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
      todo: 'li',
      todoText: 'li label',
    };
  }

  createTodo(text) {
    const todoText = text || 'Test';
    this.browser.ctx.todoText = todoText;
    return this
      .typeTextIntoElementAndSubmit(todoText, this.selectors.newTodo);
  }

  completeTodo() {
    return this
      .clickElement(this.selectors.toggleTodo);
  }

  isTodoPresent() {
    return this
      .getElementText(this.selectors.todoText)
      .then(text => text === this.browser.ctx.todoText);
  }

  isTodoCompleted() {
    return this
      .getClassList(this.selectors.todo)
      .then(classList => classList.includes(COMPLETED_CLASS));
  }
}
