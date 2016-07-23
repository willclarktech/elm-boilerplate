import {
  getClassList,
  getText,
} from './helpers.js';

const ENTER = '\u000d';

export default class BasePage {
  constructor({ browser, path, identifier }) {
    [this.browser, this.identifier] = [browser, identifier];
    this.url = `${browser.baseUrl}${path}`;
  }

  visit() {
    return new Promise((resolve, reject) => {
      this.browser
        .goto(this.url)
        .then(resolve)
        .catch(reject);
    });
  }

  clickElement(selector) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .click(selector)
        .then(resolve)
        .catch(reject);
    });
  }

  typeTextIntoElementAndSubmit(text, selector) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .type(selector, text)
        .type(selector, ENTER)
        .then(resolve)
        .catch(reject);
    });
  }

  urlIsCurrent() {
    return new Promise((resolve, reject) => {
      this.browser
        .url()
        .then(resolve)
        .catch(reject);
    })
      .then(url => url === this.url);
  }

  elementExists(selector) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .exists(selector)
        .then(resolve)
        .catch(reject);
    });
  }

  identifierIsPresent() {
    return this
      .elementExists(this.identifier);
  }

  isLoaded() {
    return Promise.join(
      this.urlIsCurrent(),
      this.identifierIsPresent(),
      (urlIsEqual, identifierIsPresent) =>
        urlIsEqual && identifierIsPresent
    );
  }

  getClassList(selector) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .wait(10) // Nightmare too fast
        .evaluate(getClassList, selector)
        .then(resolve)
        .catch(reject);
    });
  }

  getElementText(selector) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .evaluate(getText, selector)
        .then(resolve)
        .catch(reject);
    });
  }
}
