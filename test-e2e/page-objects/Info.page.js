import BasePage from './Base.page';

export default class InfoPage extends BasePage {
  constructor({ browser }) {
    super({
      browser,
      path: '/#info',
      identifier: '#info',
    });
  }
}
