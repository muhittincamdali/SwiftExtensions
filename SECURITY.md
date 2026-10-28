# Security policy

Several extensions in SwiftExtensions exist to keep values from outside the app from crashing it
or filling its memory: numbers that may be NaN or out of range, response bodies, async sequences
and text of any length, retry settings from remote configuration. A way around one of these
guarantees is a vulnerability.

## In scope

- A value for which `Int(rounding:)`, `init(clamping:)` or `Duration(timeInterval:)` stops the
  app instead of returning `nil` or a clamped value.
- A response body that `URLSession.data(for:limit:)` returns although it is larger than the
  limit, or that it reads far beyond the limit before it throws.
- An async sequence that `collect(limit:)` or `collectData(limit:)` reads past element
  `limit + 1`.
- A `RetryPolicy` built from any input that retries more than 100 times, waits longer than its
  `maxDelay`, or traps.
- `truncated(toUTF8ByteCount:ending:)` returning more bytes than the limit or invalid text.
- `ResourceUsageAdvice.updates()` buffering more than one value, or keeping its observers after
  the stream ends.
- A data race that the package's `Sendable` types or closures allow.

## Supported versions

Security fixes are made for the latest release. 1.x is no longer maintained.

## Reporting a vulnerability

Please report vulnerabilities privately, not in a public issue, pull request or discussion.

1. **Preferred:** open the repository's **Security** tab and choose
   **Report a vulnerability** ([how private reporting works](https://docs.github.com/en/code-security/how-tos/report-and-fix-vulnerabilities/report-privately)).
2. **Or** email [muhittincamdali@gmail.com](mailto:muhittincamdali@gmail.com) with
   "Security" in the subject.

Include the version (tag or commit), the input that shows the problem, and what you expected to
happen.

## What happens next

- You get a reply within 7 days confirming that the report arrived.
- The issue is confirmed, fixed with a test that reproduces it, and released together with a
  GitHub security advisory on a disclosure date agreed with you.
- You are credited in the advisory unless you prefer not to be.
