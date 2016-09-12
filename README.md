# elm-boilerplate

[![devDependency Status](https://david-dm.org/LikeJasper/elm-boilerplate/dev-status.svg)](https://david-dm.org/LikeJasper/elm-boilerplate)

## About

This project incorporates ideas from https://github.com/gkubisa/elm-app-boilerplate and https://github.com/xolvio/automated-testing-best-practices to provide an elm app boilerplate intended for development in conformity with Konstantin Kudryashov’s [Modelling by Example](http://stakeholderwhisperer.com/posts/2014/10/introducing-modelling-by-example) BDD/DDD methodology.

The broader project will incorporate a purely static site hosted on GitHub Pages (this repo) plus a backend (yet to be developed).

## Setup

### Terminal arrangement

1\. Start the development server
```
npm run dev
```
2\. Start the mock json server
```
npm run api:mock
```
3\. Start the end-to-end tests
```
npm run test:e2e:watch
```
4\. Start the unit tests
```
npm run test:unit:watch
```

### Mock server

This uses [json-server](https://github.com/typicode/json-server) to provide a simple, discardable json backend which can store and return data sent to/fetched from predictable endpoints.

### Browser arrangement

1. When the development server is started, a browser window should open at `localhost:3000` showing the app.
1. The app can also be accessed on the local network at the address displayed in the development server terminal window.
1. The BrowserSync control panel can be found at the same address on port `3001`. (E.g. use your phone as a BrowserSync controller!)

## Development process

1. Add a feature file in `features`.
1. Cucumber will give you boilerplate code to put as your step definitions in `./test-e2e/step-definitions`. Double check the regular expressions, then implement the steps. End-to-end tests should fail.
1. Add an elm test suite for the feature in `./test-unit/[AppName]Test`. Write tests which will help you pass the currently failing aspect of the end-to-end tests. Tests should fail.
1. Write elm code in `./elm/[AppName]` to pass the tests.

### Features

Features are written in Gherkin and should be *specific* regarding the domain language, and *unspecific* regarding the technical implementation. That is, use concrete details about the example situations your feature should deal with and the feedback it should provide, but not about how the feature gets from input to output.

Ideally feature files should be written with so little implementation specificity that they can be reused for e.g. end-to-end and api tests, just with different step definitions.

### Step definitions

1. `Given` steps are for setup and should ideally manipulate state directly rather than using the API under development.
1. `When` steps are for calling the functions under test.
1. `Then` steps are for making assertions on the final state.

In addition, relevant variables can be stored in or accessed from the browser context.

In end-to-end tests, interactions with pages should be defined in page objects, rather than directly in the step definitions.

### Page objects

There should be one for each different page. Page objects extend a Base page class, which defines common methods such as visiting the page or typing text into an element.

## Deployment

When you’re ready to deploy what you have in `./dev`:

1. Switch your environment: change `./src/Env/Current.elm` to import from `Env.Production` instead of `Env.Development`.
1. Recompile with production environment: rerun `npm run dev` if it isn’t already running.
1. Deploy by running this script:

```
npm run deploy:straight
```

This will copy your `./dev` directory into `./dist`, apply some compression, and push to your `gh-pages` branch. You can also use `npm run deploy:mangle` to make your scripts less readable, although there’s no point if you’re pushing the source code to a public repo as in this example.
