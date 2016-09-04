module.exports = function givenSteps() {
  this.Given(/^I am on the Todos page$/, function () {
    return this.todosPage.visit();
  });

  this.Given(/^I have created a todo$/, function () {
    const todoText = 'Test';
    this.browser.ctx.todoText = todoText;
    return this.todosPage.createTodo(todoText);
  });

  this.Given(/^I have created (\d+) Todos$/, function (numberOfTodos) {
    const todoTexts = [];
    for (let i = 0; i < numberOfTodos; ++i) {
      todoTexts.push(`Test ${i}`);
    }
    this.browser.ctx.todoTexts = todoTexts;
    return this.todosPage.createTodos(todoTexts);
  });

  this.Given(/^I have marked the todo as complete$/, function () {
    return this.todosPage.markTodoAsComplete();
  });

  this.Given(/^I have completed (\d+) Todos$/, function (numberOfTodos) {
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

    return this.todosPage.markTodosAsComplete(completedIndices);
  });

  this.Given(/^I have filtered for completed Todos$/, function () {
    return this.todosPage.filter('completed');
  });

  this.Given(/^I have a Facebook account$/, function (callback) {
    this.browser.ctx.user = {
      name: 'Testy McTestface',
      email: 'testy_srtiwyc_mctestface@tfbnw.net',
      password: 'testing123',
    };
    callback();
  });

  this.Given(/^I have logged in with Facebook$/, function () {
    const { email, password } = this.browser.ctx.user;
    return this.todosPage.login()
      .then(() => this.facebookLoginPage.login(email, password));
  });
};
