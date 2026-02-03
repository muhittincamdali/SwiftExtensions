# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.2.x   | :white_check_mark: |
| 1.1.x   | :white_check_mark: |
| < 1.1   | :x:                |

## Reporting a Vulnerability

Please report security issues to: security@muhittincamdali.com

**Do NOT open public issues for security vulnerabilities.**

## Security Considerations

SwiftExtensions includes utilities that may handle sensitive data:

### String Extensions
- Ensure proper encoding when handling user input
- Use secure comparison for sensitive strings

### Keychain Extensions
- Always use appropriate access control
- Handle biometric failures gracefully

### Data Extensions
- Be cautious with encoding/decoding untrusted data

## Best Practices

```swift
// ✅ Safe: Using secure comparison
let isMatch = securePassword.secureCompare(userInput)

// ❌ Unsafe: Direct comparison
let isMatch = securePassword == userInput
```

Thank you for helping keep SwiftExtensions secure! 🛡️
