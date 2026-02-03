# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New Date formatting extensions
- UIKit to SwiftUI bridging extensions

## [1.2.0] - 2026-02-06

### Added
- **String Extensions**
  - `isValidEmail`, `isValidURL`, `isValidPhoneNumber`
  - `truncated(to:)`, `words`, `lines`
  - `localized`, `camelCased`, `snakeCased`
  - HTML/URL encoding/decoding
  - Regular expression helpers

- **Array Extensions**
  - `safe` subscript with bounds checking
  - `chunked(into:)` for pagination
  - `unique()` and `uniqueBy(_:)`
  - `grouped(by:)` for categorization
  - `prepend(_:)` and `appending(_:)`

- **Date Extensions**
  - `isToday`, `isYesterday`, `isTomorrow`
  - `startOfDay`, `endOfDay`, `startOfWeek`
  - `adding(_:to:)` component manipulation
  - `formatted(as:)` with custom patterns
  - `timeAgo` relative formatting

- **Optional Extensions**
  - `or(_:)` default value
  - `isNil`, `isNotNil`
  - `filter(_:)` conditional unwrap

- **Collection Extensions**
  - `isNotEmpty`
  - `sorted(by:ascending:)`
  - `count(where:)`

### Changed
- Improved performance for large collections
- Enhanced Swift 6 compatibility

### Fixed
- Thread safety issues in caching extensions

## [1.1.0] - 2026-01-15

### Added
- UIView animation extensions
- UIColor hex initialization
- Bundle version helpers
- FileManager convenience methods

## [1.0.0] - 2026-01-01

### Added
- Initial release with 500+ extensions
- Full documentation
- Example playground

[Unreleased]: https://github.com/muhittincamdali/SwiftExtensions/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/muhittincamdali/SwiftExtensions/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/muhittincamdali/SwiftExtensions/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/muhittincamdali/SwiftExtensions/releases/tag/v1.0.0
