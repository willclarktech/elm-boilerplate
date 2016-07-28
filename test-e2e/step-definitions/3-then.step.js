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

  this.Then(/^I should not see the Todo$/, function () {
    return this
      .expect(this.todosPage.isTodoPresent())
      .eventually.to.be.false;
  });

  this.Then(/^I should see the Todos I have completed$/, function (callback) {
    // Write code here that turns the phrase above into concrete actions
    callback(null, 'pending');
  });

  this.Then(/^I should see the Todos I have not completed$/, function (callback) {
    // Write code here that turns the phrase above into concrete actions
    callback(null, 'pending');
  });

  this.Then(/^I should not see the Todos I have completed$/, function (callback) {
    // Write code here that turns the phrase above into concrete actions
    callback(null, 'pending');
  });

  this.Then(/^I should not see the Todos I have not completed$/, function (callback) {
    // Write code here that turns the phrase above into concrete actions
    callback(null, 'pending');
  });
};
