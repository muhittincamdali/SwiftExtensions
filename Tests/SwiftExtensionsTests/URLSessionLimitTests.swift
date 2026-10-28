import Foundation
import Synchronization
import Testing
import SwiftExtensions

/// Answers requests from a table of canned responses, so the tests need no network.
final class StubURLProtocol: URLProtocol {
    struct Stub: Sendable {
        var body: Data
        var headers: [String: String] = [:]
    }

    private static let stubs = Mutex<[URL: Stub]>([:])

    static func register(_ stub: Stub, for url: URL) {
        stubs.withLock { $0[url] = stub }
    }

    override class func canInit(with request: URLRequest) -> Bool {
        request.url?.host == "stub.test"
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        guard let url = request.url, let stub = Self.stubs.withLock({ $0[url] }) else {
            client?.urlProtocol(self, didFailWithError: URLError(.fileDoesNotExist))
            return
        }
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: stub.headers)!
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: stub.body)
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}

    static func session() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [StubURLProtocol.self]
        return URLSession(configuration: configuration)
    }
}

@Suite("URLSession.data(for:limit:)")
struct URLSessionLimitTests {
    private let session = StubURLProtocol.session()

    private func stub(_ name: String, bytes: Int, contentLength: String? = nil) -> URL {
        let url = URL(string: "https://stub.test/\(name)")!
        var headers: [String: String] = [:]
        if let contentLength { headers["Content-Length"] = contentLength }
        StubURLProtocol.register(.init(body: Data(repeating: 7, count: bytes), headers: headers), for: url)
        return url
    }

    @Test func returnsABodyThatFits() async throws {
        let url = stub("fits", bytes: 1_000, contentLength: "1000")
        let (data, response) = try await session.data(from: url, limit: 1_000)
        #expect(data == Data(repeating: 7, count: 1_000))
        #expect((response as? HTTPURLResponse)?.statusCode == 200)
    }

    @Test func refusesAnAnnouncedLengthAboveTheLimit() async {
        let url = stub("announced", bytes: 5_000, contentLength: "5000")
        await #expect(throws: ResponseTooLargeError(limit: 4_999, expectedLength: 5_000)) {
            try await session.data(from: url, limit: 4_999)
        }
    }

    @Test func stopsABodyWithoutALengthAtTheLimit() async {
        let url = stub("unannounced", bytes: 300_000)
        await #expect(throws: ResponseTooLargeError(limit: 100_000, expectedLength: nil)) {
            try await session.data(for: URLRequest(url: url), limit: 100_000)
        }
    }

    @Test func aNegativeLimitAcceptsOnlyAnEmptyBody() async throws {
        let empty = stub("empty", bytes: 0)
        #expect(try await session.data(from: empty, limit: -1).0.isEmpty)
        let one = stub("one-byte", bytes: 1)
        await #expect(throws: ResponseTooLargeError.self) {
            try await session.data(from: one, limit: -1)
        }
    }

    @Test func passesOnTransferErrors() async {
        let missing = URL(string: "https://stub.test/missing")!
        await #expect(throws: URLError.self) {
            try await session.data(from: missing, limit: 10)
        }
    }

    @Test func theErrorNamesTheLimit() {
        #expect(ResponseTooLargeError(limit: 10, expectedLength: 20).description.contains("20"))
        #expect(ResponseTooLargeError(limit: 10, expectedLength: nil).description.contains("10"))
    }
}
