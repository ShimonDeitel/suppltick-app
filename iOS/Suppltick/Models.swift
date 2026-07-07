import Foundation

struct LogEntry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var date: Date
    var value1: Double
    var value2: Double
    var notes: String

    static let value1Label = "Amount"
    static let value1Unit = "units"
    static let value2Label = "Time taken (hr)"
    static let value2Unit = "hr"
    static let notesLabel = "Supplement notes"
    static let entryNoun = "Dose"
}
