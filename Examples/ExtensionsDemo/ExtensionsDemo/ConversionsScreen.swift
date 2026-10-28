import SwiftExtensions
import SwiftUI

/// Shows what the non-trapping conversions return for values that stop the app with the
/// standard initializers.
struct ConversionsScreen: View {
    private struct Sample: Identifiable {
        let label: String
        let value: Double
        var id: String { label }
    }

    private let samples = [
        Sample(label: "2.5", value: 2.5),
        Sample(label: "-0.6", value: -0.6),
        Sample(label: "300", value: 300),
        Sample(label: "0 / 0", value: 0.0 / 0.0),
        Sample(label: "1 / 0", value: 1.0 / 0.0),
        Sample(label: "Double(Int.max)", value: Double(Int.max))
    ]

    var body: some View {
        List {
            Section {
                ForEach(samples) { sample in
                    row(for: sample)
                }
            } header: {
                Text("Each value below stops the app with Int(x), UInt8(x) or Duration.seconds(x)")
                    .textCase(nil)
            }
        }
    }

    private func row(for sample: Sample) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(sample.label)
                .font(.headline.monospaced())
            result("Int(rounding:)", Int(rounding: sample.value).map(String.init))
            result("UInt8(clamping:)", UInt8(clamping: sample.value).map(String.init))
            result("Duration(timeInterval:)", Duration(timeInterval: sample.value).map(format))
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("conversion-\(sample.label)")
    }

    private func result(_ name: String, _ value: String?) -> some View {
        HStack {
            Text(name)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value ?? "nil")
                .foregroundStyle(value == nil ? Color.orange : Color.primary)
        }
        .font(.caption.monospaced())
    }

    private func format(_ duration: Duration) -> String {
        duration.formatted(.units(allowed: [.seconds, .milliseconds], width: .narrow))
    }
}
