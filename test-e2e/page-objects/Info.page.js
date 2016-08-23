import BasePage from './Base.page';

export default class InfoPage extends BasePage {
  constructor({ browser }) {
    const path = '/info';
    const identifier = '#info';

    super({
      browser,
      path,
      identifier,
    });
  }
}
