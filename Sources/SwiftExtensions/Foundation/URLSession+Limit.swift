import Foundation

/// The error that ``Foundation/URLSession/data(for:limit:)`` throws when a response body is
/// larger than the limit.
public struct ResponseTooLargeError: Error, Hashable, CustomStringConvertible {
    /// The largest number of bytes that was allowed.
    public let limit: Int
    /// The length the server announced in `Content-Length`, when it announced one.
    public let expectedLength: Int64?

    /// Creates the error for a limit and the announced length.
    public init(limit: Int, expectedLength: Int64?) {
        self.limit = limit
        self.expectedLength = expectedLength
    }

    public var description: String {
        if let expectedLength {
            return "The response announced \(expectedLength) bytes; the limit is \(limit)."
        }
        return "The response body is larger than \(limit) bytes."
    }
}

extension URLSession {
    /// Downloads the body of a request into memory, and stops as soon as it is larger than
    /// `limit` bytes.
    ///
    /// `data(for:)` reads the whole body, however large the server makes it. This method
    /// refuses a response whose `Content-Length` is above the limit before reading any of it,
    /// and stops a body without a length, or with a wrong one, at byte `limit + 1`. In both cases
    /// the transfer is cancelled and ``ResponseTooLargeError`` is thrown.
    ///
    /// ```swift
    /// let (data, response) = try await URLSession.shared.data(for: request, limit: 2_000_000)
    /// ```
    ///
    /// - Parameters:
    ///   - request: The request to send.
    ///   - limit: The largest body to accept, in bytes; values below 0 count as 0.
    /// - Returns: The body and the response.
    /// - Throws: ``ResponseTooLargeError``, or the error of the transfer.
    public func data(for request: URLRequest, limit: Int) async throws -> (Data, URLResponse) {
        let limit = Swift.max(0, limit)
        let (bytes, response) = try await self.bytes(for: request)
        let announced = response.expectedContentLength
        if announced > Int64(limit) {
            bytes.task.cancel()
            throw ResponseTooLargeError(limit: limit, expectedLength: announced)
        }
        do {
            let data = try await bytes.collectData(limit: limit)
            return (data, response)
        } catch is CollectLimitExceededError {
            bytes.task.cancel()
            throw ResponseTooLargeError(
                limit: limit,
                expectedLength: announced >= 0 ? announced : nil
            )
        }
    }

    /// Downloads the contents of a URL into memory, and stops as soon as it is larger than
    /// `limit` bytes. See ``data(for:limit:)``.
    public func data(from url: URL, limit: Int) async throws -> (Data, URLResponse) {
        try await data(for: URLRequest(url: url), limit: limit)
    }
}
