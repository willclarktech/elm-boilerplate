import BasePage from './Base.page';

const COMPLETED_CLASS = 'completed';
const FILTER_COMPLETED = 'completed';
const FILTER_INCOMPLETE = 'incomplete';
const FILTER_ALL = 'all';

export default class TodosPage extends BasePage {
  constructor({ browser }) {
    const identifier = '#new-todo';

    super({
      browser,
      path: '/',
      identifier,
    });

    this.selectors = {
      identifier,
      newTodo: '#new-todo',
      toggleTodo: '.toggle',
      deleteTodo: '.delete',
      todo: 'li',
      todoText: 'li label',
      todoEditBox: '.edit',
      filterAll: '#filter-all',
      filterCompleted: '#filter-completed',
      filterIncomplete: '#filter-incomplete',
      loginButton: '#fb-login',
      fbStatus: '#fb-status',
      saveButton: '#save',
    };
  }

  createTodo(todoText = 'Test') {
    return this
      .typeTextIntoElementAndSubmit(todoText, this.selectors.newTodo);
  }

  createTodos(todoTexts) {
    return todoTexts
      .reduce((previousText, nextText) => previousText
        .then(() => this
          .typeTextIntoElementAndSubmit(nextText, this.selectors.newTodo)
        ), Promise.resolve()
      );
  }

  markTodoAsComplete(selector = this.selectors.toggleTodo) {
    return this
      .clickElement(selector);
  }

  markTodoAsIncomplete(selector = this.selectors.toggleTodo) {
    return this
      .clickElement(selector);
  }

  markTodosAsComplete(completedIndices) {
    return Promise.map(
      completedIndices,
      index => this.markTodoAsComplete(`#todo-${index} .toggle`)
    );
  }

  editTodo(newTodoText = 'Edited') {
    return this
      .clickElement(this.selectors.todoText)
      .then(() => this
        .clearInput(this.selectors.todoEditBox)
      )
      .then(() => this
        .typeTextIntoElementAndSubmit(newTodoText, this.selectors.todoEditBox)
      );
  }

  deleteTodo() {
    return this
      .clickElement(this.selectors.deleteTodo);
  }

  filter(status) {
    switch (status) {
      case FILTER_COMPLETED:
        return this
          .clickElement(this.selectors.filterCompleted);
      case FILTER_INCOMPLETE:
        return this
          .clickElement(this.selectors.filterIncomplete);
      case FILTER_ALL:
      default:
        return this
          .clickElement(this.selectors.filterAll);
    }
  }

  login() {
    return this
      .clickElement(this.selectors.loginButton);
  }

  save() {
    return this
      .clickElement(this.selectors.saveButton);
  }

  isTodoPresent(todoText) {
    return this
      .getElementText(this.selectors.todoText)
      .then(text => text === todoText)
      .catch(() => false);
  }

  isTodoCompleted() {
    return this
      .getClassList(this.selectors.todo)
      .then(classList => classList.includes(COMPLETED_CLASS));
  }

  isTodoUpdated(editedText) {
    return this
      .getElementText(this.selectors.todoText)
      .then(text => text === editedText);
  }

  getTodos() {
    return this
      .getElementTextForEach(this.selectors.todoText)
      .catch(() => []);
  }

  getLoginName() {
    return this
      .getElementText(this.selectors.fbStatus);
  }
}
