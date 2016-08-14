import BasePage from './Base.page';

export default class FacebookLoginPage extends BasePage {
  constructor({ browser }) {
    const baseUrl = 'https://www.facebook.com';
    const path = '/login.php';
    const identifier = 'html#facebook';

    super({
      browser,
      baseUrl,
      path,
      identifier,
    });

    this.selectors = {
      emailInput: '#email',
      passwordInput: '#pass',
    };
  }

  login(email, password) {
    const { emailInput, passwordInput } = this.selectors;
    return this
      .clearInput(emailInput)
      .then(() => this.typeTextIntoElement(email, emailInput))
      .then(() => this.typeTextIntoElementAndSubmit(password, passwordInput));
  }
}
