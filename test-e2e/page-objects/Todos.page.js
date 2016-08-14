import BasePage from './Base.page';

const COMPLETED_CLASS = 'completed';
const FILTER_COMPLETED = 'completed';
const FILTER_INCOMPLETE = 'incomplete';
const FILTER_ALL = 'all';

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
      todoEditBox: '.edit',
      filterAll: '#filter-all',
      filterCompleted: '#filter-completed',
      filterIncomplete: '#filter-incomplete',
      loginButton: '#fb-login',
      fbStatus: '#fb-status',
    };

    this.fbSelectors = {
      emailInput: '#email',
      passwordInput: '#pass',
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

  createTodos(numberOfTodos) {
    const todoTexts = [];
    for (let i = 0; i < numberOfTodos; ++i) {
      todoTexts.push(`Test ${i}`);
    }
    this.browser.ctx.todoTexts = todoTexts;
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

  markTodosAsComplete(numberOfTodos) {
    const todoTexts = [...this.browser.ctx.todoTexts];
    if (numberOfTodos > todoTexts.length) {
      throw new Error('You are trying to complete more todos than there are!');
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

    return Promise.map(
      completedIndices,
      index => this.markTodoAsComplete(`#todo-${index} .toggle`)
    );
  }

  editTodo(text) {
    const newTodoText = typeof text === 'undefined'
      ? 'Edited'
      : text;

    this.browser.ctx.editedText = newTodoText;

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

  login(email, password) {
    const { loginButton } = this.selectors;
    const { emailInput, passwordInput } = this.fbSelectors;
    return this
      .clickElement(loginButton)
      .then(() => this.typeTextIntoElement(email, emailInput))
      .then(() => this.typeTextIntoElementAndSubmit(password, passwordInput));
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

  isTodoUpdated() {
    return this
      .getElementText(this.selectors.todoText)
      .then(text => text === this.browser.ctx.editedText);
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
