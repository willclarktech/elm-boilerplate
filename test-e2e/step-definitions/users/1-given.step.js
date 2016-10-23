import { facebookUser } from '../../../fixtures';

export default function givenSteps() {
  this.Given(/^I have a Facebook account$/, function (callback) {
    this.browser.ctx.user = facebookUser;
    callback();
  });

  this.Given(/^I have logged in with Facebook$/, function () {
    const { email, password } = this.browser.ctx.user;
    return this.todosPage.login()
      .then(() => this.facebookLoginPage.login(email, password));
  });
}
