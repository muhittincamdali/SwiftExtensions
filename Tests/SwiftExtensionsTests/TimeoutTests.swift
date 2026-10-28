import Foundation
import Synchronization
import Testing
import SwiftExtensions

@Suite("withTimeout")
struct TimeoutTests {
    @Test func returnsTheValueOfAFastOperation() async throws {
        let value = try await withTimeout(.seconds(10)) { 42 }
        #expect(value == 42)
    }

    @Test func throwsTimeoutErrorAndCancelsASlowOperation() async throws {
        let wasCancelled = Mutex(false)
        let started = ContinuousClock.now
        await #expect(throws: TimeoutError(timeout: .milliseconds(50))) {
            try await withTimeout(.milliseconds(50)) {
                do {
                    try await Task.sleep(for: .seconds(30))
                } catch {
                    wasCancelled.withLock { $0 = true }
                    throw error
                }
            }
        }
        #expect(wasCancelled.withLock { $0 })
        #expect(ContinuousClock.now - started < .seconds(10))
    }

    @Test(arguments: [Duration.zero, .milliseconds(-1), .seconds(-60)])
    func aLimitOfZeroOrLessThrowsWithoutRunningTheOperation(limit: Duration) async {
        let ran = Mutex(false)
        await #expect(throws: TimeoutError(timeout: limit)) {
            try await withTimeout(limit) {
                ran.withLock { $0 = true }
            }
        }
        #expect(!ran.withLock { $0 })
    }

    @Test func passesOnTheErrorOfTheOperation() async {
        struct Failure: Error, Equatable {}
        await #expect(throws: Failure()) {
            try await withTimeout(.seconds(10)) { () async throws -> Int in throw Failure() }
        }
    }

    @Test func aCancelledTaskThrowsCancellationErrorWithoutRunningTheOperation() async {
        let ran = Mutex(false)
        let task = Task {
            withUnsafeCurrentTask { $0?.cancel() }
            return try await withTimeout(.seconds(10)) {
                ran.withLock { $0 = true }
            }
        }
        await #expect(throws: CancellationError.self) { try await task.value }
        #expect(!ran.withLock { $0 })
    }

    @MainActor
    @Test func runsAMainActorOperationOnTheMainActor() async throws {
        let isMain = try await withTimeout(.seconds(10)) { @MainActor in
            pthread_main_np() == 1
        }
        #expect(isMain)
    }

    @Test func theErrorDescribesTheLimit() {
        #expect(TimeoutError(timeout: .seconds(2)).description.contains("2"))
    }
}
