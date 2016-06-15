  module.exports = function() {
    this.When(/^I visit the homepage$/, function () {
      return this.browser.visit('/');
    });
  }
