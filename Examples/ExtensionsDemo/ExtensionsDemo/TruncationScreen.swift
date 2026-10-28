import SwiftExtensions
import SwiftUI

/// Truncates the text in a field to a byte limit chosen with a stepper.
struct TruncationScreen: View {
    @State private var text = "Grüße 👋🏽 from İstanbul 👨‍👩‍👧‍👦"
    @State private var limit = 20
    @State private var addsEllipsis = true

    private var result: String {
        text.truncated(toUTF8ByteCount: limit, ending: addsEllipsis ? "…" : "")
    }

    var body: some View {
        Form {
            Section("Text") {
                TextField("Text", text: $text, axis: .vertical)
                    .accessibilityIdentifier("truncation-input")
                LabeledContent("Length", value: "\(text.count) characters, \(text.utf8.count) bytes")
            }
            Section("Limit") {
                Stepper("\(limit) bytes", value: $limit, in: 0...64)
                    .accessibilityIdentifier("truncation-limit")
                Toggle("End with …", isOn: $addsEllipsis)
            }
            Section("Result") {
                Text(result)
                    .font(.title3)
                    .accessibilityIdentifier("truncation-result")
                LabeledContent("Bytes", value: "\(result.utf8.count) of \(limit)")
                    .accessibilityIdentifier("truncation-bytes")
            }
        }
    }
}
