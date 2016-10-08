export default function thenSteps() {
  this.Then(/^The page should load$/, function () {
    return this
      .expect(this.todosPage.isLoaded())
      .eventually.to.be.true;
  });

  this.Then(/^I should see the Todo$/, function () {
    const { todoText } = this.browser.ctx;
    return this
      .expect(this.todosPage.isTodoPresent(todoText))
      .eventually.to.be.true;
  });

  this.Then(/^I should see that the Todo is completed$/, function () {
    return this
      .expect(this.todosPage.isTodoCompleted())
      .eventually.to.be.true;
  });

  this.Then(/^I should see that the Todo is not completed$/, function () {
    return this
      .expect(this.todosPage.isTodoCompleted())
      .eventually.to.be.false;
  });

  this.Then(/^I should not see the Todo$/, function () {
    const { todoText } = this.browser.ctx;
    return this
      .expect(this.todosPage.isTodoPresent(todoText))
      .eventually.to.be.false;
  });

  this.Then(/^I should see the Todos I have (completed|not completed)$/, function (status) {
    const relevantTodos = status === 'completed'
      ? this.browser.ctx.completedTodos
      : this.browser.ctx.incompleteTodos;

    return this.todosPage
      .getTodos()
      .then(todos => relevantTodos
        .map(todo => this
          .expect(todos.includes(todo))
          .to.be.true
        )
      );
  });

  this.Then(/^I should not see the Todos I have (completed|not completed)$/, function (status) {
    const relevantTodos = status === 'completed'
      ? this.browser.ctx.completedTodos
      : this.browser.ctx.incompleteTodos;

    return this.todosPage
      .getTodos()
      .then(todos => relevantTodos
        .map(todo => this
          .expect(todos.includes(todo))
          .to.be.false
        )
      );
  });

  this.Then(/^I should see all of the Todos$/, function () {
    return this.todosPage
      .getTodos()
      .then(todos => this.browser.ctx.todoTexts
        .map(todo => this
          .expect(todos.includes(todo))
          .to.be.true
        )
      );
  });

  this.Then(/^I should see that the Todo is updated$/, function () {
    const { editedText } = this.browser.ctx;
    return this
      .expect(this.todosPage.isTodoUpdated(editedText))
      .eventually.to.be.true;
  });

  this.Then(/^I should be greeted by name$/, function () {
    return this
      .expect(this.todosPage.getLoginName())
      .eventually.to.equal(this.browser.ctx.user.name);
  });

  this.Then(/^I should get some info$/, function () {
    return this
      .expect(this.infoPage.identifierIsPresent())
      .eventually.to.be.true;
  });
}
