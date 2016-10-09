export default function whenSteps() {
  this.When(/^I log in with Facebook$/, function () {
    const { email, password } = this.browser.ctx.user;
    return this.todosPage.login()
      .then(() => this.facebookLoginPage.login(email, password));
  });
}
