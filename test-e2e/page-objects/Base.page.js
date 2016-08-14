import {
  getClassList,
  getText,
  getAllTexts,
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
        .then(resolve, reject);
    });
  }

  clickElement(selector) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .wait(200) // Nightmare too fast
        .click(selector)
        .then(resolve, reject);
    });
  }

  clearInput(selector) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .insert(selector, null)
        .then(resolve, reject);
    });
  }

  typeTextIntoElement(text, selector) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .wait(50)
        .insert(selector, text)
        .wait(200)
        .then(resolve, reject);
    });
  }

  typeTextIntoElementAndSubmit(text, selector) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .wait(50)
        .insert(selector, text)
        .wait(50)
        .type(selector, ENTER)
        .wait(200)
        .then(resolve, reject);
    });
  }

  urlIsCurrent() {
    return new Promise((resolve, reject) => {
      this.browser
        .url()
        .then(resolve, reject);
    })
      .then(url => url === this.url);
  }

  elementExists(selector) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .exists(selector)
        .then(resolve, reject);
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
        .wait(20) // Nightmare too fast
        .evaluate(getClassList, selector)
        .then(resolve, reject);
    });
  }

  getElementText(selector) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .evaluate(getText, selector)
        .then(resolve, reject);
    });
  }

  getElementTextForEach(selector) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .wait(20)
        .evaluate(getAllTexts, selector)
        .then(resolve, reject);
    });
  }
}
