import Foundation
import Synchronization
import Testing
import SwiftExtensions

/// Runs the README samples (ReadmeSamples.swift) so that what the README says they do is checked.
@Suite("README samples")
struct ReadmeSampleTests {
    @Test func theQuickStartStopsTheSlowCallAfterOneSecond() async {
        // The README sample races a 1 second limit against a 3 second sleep. A runner that stalls
        // the process for two seconds lets both timers expire together, and the sleep can win.
        // A broken timeout fails every attempt, a stall only one.
        let expected = "Stopped after 1 second"
        var result = await waitWithLimit()
        for _ in 1..<3 where result != expected {
            result = await waitWithLimit()
        }
        #expect(result == expected, "waitWithLimit returned \(result)")
    }

    @Test func theProgressLabelSurvivesADivisionByZero() {
        #expect(progressLabel(done: 1, total: 4) == "25 %")
        #expect(progressLabel(done: 0, total: 0) == "–")
        #expect(progressLabel(done: 1, total: 0) == "–")
    }

    @Test func theRetryHeaderFallsBackForValuesWithoutADuration() {
        #expect(retryDelay(fromHeader: "2.5") == .milliseconds(2_500))
        #expect(retryDelay(fromHeader: "1e400") == .seconds(5))
        #expect(retryDelay(fromHeader: "nan") == .seconds(5))
        #expect(retryDelay(fromHeader: "-3") == .seconds(5))
        #expect(retryDelay(fromHeader: nil) == .seconds(5))
    }

    @Test func thePushTitleFitsItsColumn() {
        let title = pushTitle(for: String(repeating: "Ö", count: 40))
        #expect(title.utf8.count <= 64)
        #expect(title.hasSuffix("…"))
        #expect(pushTitle(for: "Ada") == "New message from Ada")
    }

    @Test func thumbnailsRetryFailuresAndKeepTheOrder() async throws {
        let library = FlakyLibrary()
        let images = try await thumbnails(for: Array(1...10), from: library)
        #expect(images == (1...10).map { Data([UInt8($0)]) })
        #expect(library.failures == 10)
    }
}

/// Fails the first request for every photo, then returns one byte with the photo's number.
private final class FlakyLibrary: PhotoLibrary {
    private let failed = Mutex<Set<Int>>([])

    var failures: Int { failed.withLock { $0.count } }

    func thumbnail(for id: Int) async throws -> Data {
        let isFirstTry = failed.withLock { $0.insert(id).inserted }
        if isFirstTry { throw URLError(.timedOut) }
        return Data([UInt8(id)])
    }
}
