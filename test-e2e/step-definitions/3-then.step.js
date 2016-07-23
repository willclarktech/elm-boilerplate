module.exports = function thenSteps() {
  this.Then(/^The page should load$/, function () {
    return this
      .expect(this.todosPage.isLoaded())
      .eventually.to.be.true;
  });

  this.Then(/^I should see the Todo$/, function () {
    return this
      .expect(this.todosPage.isTodoPresent())
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
};
