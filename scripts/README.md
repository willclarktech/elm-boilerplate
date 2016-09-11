
# Helper scripts

## `pretty-error.js`

This will make your node scripts output nicer-looking errors. Just require it in the relevant script.

## `validate-commit-message.js`

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

## `workaround-elm-test-and-navigation.js`

There’s an incompatibility between `elm-community/elm-test` and `elm-lang/navigation`, for which this script provides a workaround.
