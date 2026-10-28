import Foundation
import Synchronization
import Testing
import SwiftExtensions

// Serialized: the tests post process-wide notifications that the other tests would also see.
@Suite("ResourceUsageAdvice", .serialized)
struct ResourceUsageAdviceTests {
    private func advice(
        system: Bool? = nil,
        lowPower: Bool = false,
        thermal: ProcessInfo.ThermalState = .nominal
    ) -> ResourceUsageAdvice {
        ResourceUsageAdvice(
            systemPrefersReducedResourceUsage: system,
            isLowPowerModeEnabled: lowPower,
            thermalState: thermal
        )
    }

    @Test func noSignalMeansFullWork() {
        #expect(!advice().shouldReduceWork)
        #expect(!advice(system: false, thermal: .fair).shouldReduceWork)
    }

    @Test func eachSignalAloneReducesWork() {
        #expect(advice(system: true).shouldReduceWork)
        #expect(advice(lowPower: true).shouldReduceWork)
        #expect(advice(thermal: .serious).shouldReduceWork)
        #expect(advice(thermal: .critical).shouldReduceWork)
    }

    @Test func theSystemPreferenceDoesNotHideTheOtherSignals() {
        #expect(advice(system: false, lowPower: true).shouldReduceWork)
        #expect(advice(system: false, thermal: .critical).shouldReduceWork)
    }

    @Test func currentReadsTheProcessState() {
        let process = ProcessInfo.processInfo
        let current = ResourceUsageAdvice.current(systemPrefersReducedResourceUsage: true)
        #expect(current.systemPrefersReducedResourceUsage == true)
        #expect(current.isLowPowerModeEnabled == process.isLowPowerModeEnabled)
        #expect(current.thermalState == process.thermalState)
        #expect(ResourceUsageAdvice.current().systemPrefersReducedResourceUsage == nil)
    }

    @Test func updatesStartWithTheCurrentAdvice() async {
        var iterator = ResourceUsageAdvice.updates(systemPrefersReducedResourceUsage: false).makeAsyncIterator()
        let first = await iterator.next()
        #expect(first == .current(systemPrefersReducedResourceUsage: false))
    }

    @Test func updatesFollowPowerStateNotifications() async {
        let stream = ResourceUsageAdvice.updates(systemPrefersReducedResourceUsage: true)
        var iterator = stream.makeAsyncIterator()
        _ = await iterator.next()
        NotificationCenter.default.post(name: .NSProcessInfoPowerStateDidChange, object: ProcessInfo.processInfo)
        let next = await iterator.next()
        #expect(next?.systemPrefersReducedResourceUsage == true)
    }

    @Test func updatesFollowThermalNotifications() async {
        let stream = ResourceUsageAdvice.updates()
        var iterator = stream.makeAsyncIterator()
        _ = await iterator.next()
        NotificationCenter.default.post(name: ProcessInfo.thermalStateDidChangeNotification, object: ProcessInfo.processInfo)
        #expect(await iterator.next() != nil)
    }

    @Test func manyChangesKeepOnlyTheLatestAdvice() async {
        let stream = ResourceUsageAdvice.updates()
        for _ in 0..<1_000 {
            NotificationCenter.default.post(name: .NSProcessInfoPowerStateDidChange, object: nil)
        }
        let received = Mutex(0)
        let reader = Task {
            for await _ in stream { received.withLock { $0 += 1 } }
        }
        // A loaded runner can start the reader late, so wait for the first advice instead of a
        // fixed pause, then leave time for a second one to show up.
        let deadline = ContinuousClock.now.advanced(by: .seconds(30))
        while received.withLock({ $0 }) < 1, ContinuousClock.now < deadline {
            try? await Task.sleep(for: .milliseconds(10))
        }
        try? await Task.sleep(for: .milliseconds(200))
        reader.cancel()
        await reader.value
        #expect(received.withLock { $0 } == 1)
    }
}
