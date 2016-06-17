# elm-boilerplate

## About

This project incorporates ideas from https://github.com/gkubisa/elm-app-boilerplate and https://github.com/xolvio/automated-testing-best-practices to provide an elm app boilerplate intended for development in conformity with Konstantin Kudryashov’s [Modelling by Example](http://stakeholderwhisperer.com/posts/2014/10/introducing-modelling-by-example) BDD/DDD methodology.

## Development cycle

### Terminal arrangement

1\. Start the development server
```
npm run dev
```
2\. Start the end-to-end tests
```
npm run test:e2e:watch
```
3\. Start the elm tests
```
npm run test:elm:watch
```

### Browser arrangement

1. When the development server is started, a browser window should open at `localhost:3000` showing the app.
1. The app can also be accessed on the local network at the address displayed in the development server terminal window.
1. The BrowserSync control panel can be found at the same address on port `3001`. (E.g. use your phone as a BrowserSync controller!)

### Coding arrangement

1. Add a feature file in `features`.
1. Cucumber will give you boilerplate code to put as your step definitions in `features/step_definitions`. Double check the regular expressions, then implement the steps. End-to-end tests should fail.
1. Add an elm test suite for the feature in `elm-test/App`. Write tests which will help you pass the currently failing aspect of the end-to-end tests. Tests should fail.
1. Write elm code in `elm/App` to pass the tests.

## Scripts

### `validate-commit-message.js`

This project uses [husky](https://github.com/typicode/husky) to enforce certain requirements on git commit messages. Commit messages should be 76 characters or less, and conform the following structure:
```
<type> <scope>: <subject>
```
where `<subject>` begins with a lowercase imperative verb, and `<type>` is one of the following:

- `chore` for setup-like tasks, e.g. adding dependencies
- `test` for tests, including specs
- `feat` for work on new features
- `refactor` for refactors
- `fix` for bug fixes
- `style` for changes to code style
- `docs` for stuff like this document

The validation script converts these to emoji as follows:

- `chore` -> :house_with_garden:
- `test` -> :vertical_traffic_light:
- `feat` -> :seedling:
- `refactor` -> :scissors:
- `fix` -> :wrench:
- `style` -> :lipstick:
- `docs` -> :books:

So it looks nice in GitHub, and on your command line if you use something like [emojify](https://github.com/mrowa44/emojify).
