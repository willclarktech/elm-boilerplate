export default function thenSteps() {
  this.Then(/^I should be greeted by name$/, function () {
    return this
      .expect(this.todosPage.getLoginName())
      .eventually.to.equal(this.browser.ctx.user.name);
  });
}
