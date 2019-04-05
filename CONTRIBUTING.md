# Contributing

Here are guidelines to contributing effectively to this project.

* Install an editorconfig plugin for your editor if your editor does not already
support it. This will help keep indentation, whitespace, newlines, etc.,
consistent.

* Ensure your ~/.gitignore_global file ignores metadata files for your operating
system and editor. This project's .gitignore file only ignores certain
project-related files.

* Make the smallest change in code to be effective.

* Make small commits that are focused on one concept.

* Work in short-lived feature branches.

* Make only the changes you have been asked to make.

* If you see opportunities to make other changes, check that they are required.
It may be that making a change causes more work and is therefore undesirable.

* Use standard on changed files. Fix any failures in your new code changes:

  `bundle exec standardrb --fix app lib spec`

* Do not add new dependencies unless agreed (JavaScript libraries, gems, CSS
frameworks, etc.).

## Testing

* All new functionality should be supported by tests.

* Prefer faster unit tests over slower integrated tests, so long as the faster
variants adequately test the feature.

* Run the test suite and ensure it passes before pushing changes to the
repository.

* Create request specs to test controller/view integration since this has been
the direction of Rails. Don't add new controller specs.
