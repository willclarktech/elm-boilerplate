import BasePage from './Base.page';

export default class FacebookLoginPage extends BasePage {
  constructor({ browser }) {
    super({
      browser,
      baseUrl: 'https://www.facebook.com',
      path: '/login.php',
      identifier: 'html#facebook',
    });

    this.selectors = {
      emailInput: '#email',
      passwordInput: '#pass',
    };
  }

  login(email, password) {
    const { emailInput, passwordInput } = this.selectors;
    return this
      .typeTextIntoElement(email, emailInput)
      .then(() => this.typeTextIntoElementAndSubmit(password, passwordInput));
  }
}
