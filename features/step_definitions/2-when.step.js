function depositCheck(browser) {
  return browser
    .fill('.bank-deposit .from-account-number', '987')
    .fill('.bank-deposit .branch-number', '12345')
    .fill('.bank-deposit .amount', '10')
    .pressButton('.bank-deposit .submit');
}

module.exports = function () {
  this.When(/^I visit the homepage$/, function () {
    return this.browser.visit('/');
  });

  this.When(/^I deposit the check into my account$/, function () {
    return this.browser.visit('/')
      .then(depositCheck.bind(this, this.browser));
  });
};
