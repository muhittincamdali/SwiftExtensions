import SwiftExtensions
import SwiftUI
import Synchronization

/// Runs withTimeout, withRetry and concurrentMap and shows what happened.
struct AsyncLimitsScreen: View {
    @State private var timeoutResult = "Not run"
    @State private var retryResult = "Not run"
    @State private var mapResult = "Not run"

    var body: some View {
        List {
            demo(
                "withTimeout",
                detail: "A 3 s task with a 1 s limit",
                result: timeoutResult,
                id: "timeout"
            ) { timeoutResult = await runTimeout() }
            demo(
                "withRetry",
                detail: "Fails twice, then succeeds",
                result: retryResult,
                id: "retry"
            ) { retryResult = await runRetry() }
            demo(
                "concurrentMap",
                detail: "12 jobs, at most 3 at a time",
                result: mapResult,
                id: "map"
            ) { mapResult = await runMap() }
        }
        .task {
            // `-run-demos` starts all three at launch; the screenshot script uses it.
            guard ProcessInfo.processInfo.arguments.contains("-run-demos") else { return }
            async let timeout = runTimeout()
            async let retry = runRetry()
            async let map = runMap()
            (timeoutResult, retryResult, mapResult) = await (timeout, retry, map)
        }
    }

    private func demo(
        _ title: String,
        detail: String,
        result: String,
        id: String,
        action: @escaping @MainActor () async -> Void
    ) -> some View {
        Section {
            Button("Run") {
                Task { await action() }
            }
            .accessibilityIdentifier("run-\(id)")
            Text(result)
                .font(.callout.monospaced())
                .accessibilityIdentifier("result-\(id)")
        } header: {
            Text(title).textCase(nil)
        } footer: {
            Text(detail)
        }
    }

    private func runTimeout() async -> String {
        let start = ContinuousClock.now
        do {
            try await withTimeout(.seconds(1)) {
                try await Task.sleep(for: .seconds(3))
            }
            return "Finished"
        } catch is TimeoutError {
            let elapsed = (ContinuousClock.now - start).timeInterval
            return String(format: "TimeoutError after %.1f s", elapsed)
        } catch {
            return "\(error)"
        }
    }

    private func runRetry() async -> String {
        struct Flaky: Error {}
        var log: [String] = []
        let policy = RetryPolicy(maxAttempts: 4, initialDelay: .milliseconds(200))
        do {
            let value = try await withRetry(policy) { attempt in
                log.append("attempt \(attempt)")
                if attempt < 3 { throw Flaky() }
                return "ok"
            }
            return (log + ["result: \(value)"]).joined(separator: "\n")
        } catch {
            return (log + ["failed"]).joined(separator: "\n")
        }
    }

    private func runMap() async -> String {
        let probe = PeakCounter()
        let squares = await Array(1...12).concurrentMap(maxConcurrency: 3) { number in
            probe.enter()
            try? await Task.sleep(for: .milliseconds(Int.random(in: 50...150)))
            probe.leave()
            return number * number
        }
        return "\(squares.map(String.init).joined(separator: " "))\npeak: \(probe.peak) at once"
    }
}

/// Counts the jobs running at the same time and the highest count.
private final class PeakCounter: Sendable {
    private let state = Mutex((running: 0, peak: 0))

    var peak: Int { state.withLock { $0.peak } }

    func enter() {
        state.withLock {
            $0.running += 1
            $0.peak = max($0.peak, $0.running)
        }
    }

    func leave() {
        state.withLock { $0.running -= 1 }
    }
}
