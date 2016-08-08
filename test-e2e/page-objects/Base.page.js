// @flow
import {
  getClassList,
  getText,
  getAllTexts,
} from './helpers';
import type { Browser } from '../../type-declarations/types';

const ENTER = '\u000d';

type PageConstructorArgsType = {
  browser: Browser,
  path: string,
  identifier: string,
}

export default class BasePage {
  constructor({ browser, path, identifier }: PageConstructorArgsType) {
    this.browser = browser;
    this.identifier = identifier;
    this.url = `${browser.baseUrl}${path}`;
  }

  browser: Browser
  identifier: string
  url: string

  visit() {
    return new Promise((resolve, reject) => {
      this.browser
        .goto(this.url)
        .then(resolve, reject);
    });
  }

  clickElement(selector: string) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .wait(200) // Nightmare too fast
        .click(selector)
        .then(resolve, reject);
    });
  }

  clearInput(selector: string) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .insert(selector, null)
        .then(resolve, reject);
    });
  }

  typeTextIntoElementAndSubmit(text: string, selector: string) {
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

  elementExists(selector: string) {
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

  getClassList(selector: string) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .wait(20) // Nightmare too fast
        .evaluate(getClassList, selector)
        .then(resolve, reject);
    });
  }

  getElementText(selector: string) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .evaluate(getText, selector)
        .then(resolve, reject);
    });
  }

  getElementTextForEach(selector: string) {
    return new Promise((resolve, reject) => {
      this.browser
        .wait(selector)
        .wait(20)
        .evaluate(getAllTexts, selector)
        .then(resolve, reject);
    });
  }
}
