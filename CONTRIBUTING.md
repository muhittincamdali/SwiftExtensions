# Contributing

Thanks for taking the time to improve SwiftExtensions.

## What belongs in this package

The package is small on purpose. A new extension is accepted when:

1. the standard library, Foundation and [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift)
   do not provide it, or provide it in a way that traps, has no limit or does not compile in the
   Swift 6 language mode;
2. it is correct under strict concurrency: `Sendable` types and closures whose isolation is
   stated, without `@unchecked Sendable` in the public API;
3. it comes with Swift Testing tests for its edge cases (NaN, infinity, empty input, the exact
   limit, cancellation) and a documentation comment that says why it exists.

Open an issue that explains the need before you write a large change, so that we can agree it
fits.

## Reporting bugs

Open an issue with:

- the call, the input values and what you expected,
- the platform and OS version (simulator or device) and the Xcode version.

Input that makes an extension crash, hang or use memory without bound is a security issue:
report it privately as described in [SECURITY.md](SECURITY.md).

## Pull requests

1. Fork the repository and branch from `main`.
2. Keep each pull request focused on one change, with tests for the logic it changes.
3. Run the tests on macOS and on an iPhone simulator:

    ```sh
    swift test
    xcodebuild test -scheme SwiftExtensions \
      -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
    ```

4. Build the documentation without warnings:

    ```sh
    xcodebuild docbuild -scheme SwiftExtensions \
      -destination 'generic/platform=iOS Simulator' OTHER_DOCC_FLAGS=--warnings-as-errors
    ```

5. If you change the example app, run its UI tests:

    ```sh
    cd Examples/ExtensionsDemo
    xcodebuild test -scheme ExtensionsDemo \
      -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
    ```

6. If you change a README code sample, change the copy in
   `Examples/ExtensionsDemo/ExtensionsDemo/ReadmeSamples.swift` as well. That file is what gets
   compiled: by the example app, and by `swift test` through the link
   `Tests/SwiftExtensionsTests/ReadmeSamples.swift`.
7. If the example app looks different after your change, recapture the README screenshots with
   `scripts/capture-screens.sh`.
8. `README.md` has translations (`README.<language>.md`). Each one records the version of
   `README.md` it follows, and CI fails while a translation is behind. If you change `README.md`
   and cannot update the translations, say so in the pull request and they will be updated
   before it is merged.

Use [Conventional Commits](https://www.conventionalcommits.org/) for commit messages, for example
`fix(text): keep a flag emoji whole`.

## Where things are

| Path | Contents |
| --- | --- |
| `Sources/SwiftExtensions/Concurrency` | `withTimeout`, `withRetry`, `concurrentMap`, `collect(limit:)` |
| `Sources/SwiftExtensions/Foundation` | `Duration` conversions and `URLSession` size limits |
| `Sources/SwiftExtensions/Numerics`, `Text` | Conversions that do not trap, UTF-8 truncation |
| `Sources/SwiftExtensions/UIKit`, `System` | Window scenes and `ResourceUsageAdvice` |
| `Sources/SwiftExtensions/SwiftExtensions.docc` | The documentation catalog |
| `Tests/SwiftExtensionsTests` | Swift Testing tests |
| `Examples/ExtensionsDemo` | The example app (XcodeGen spec in `project.yml`) and its UI tests |

## Code of conduct

This project follows the [Contributor Covenant](CODE_OF_CONDUCT.md).
