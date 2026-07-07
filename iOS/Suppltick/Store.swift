import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var entries: [LogEntry] = []
    @Published var categoryFilterEnabled: Bool = true
    @Published var notificationsEnabled: Bool = false

    // Free tier can hold well above the seeded entries so a fresh install never hits the paywall immediately.
    static let freeLimit = 20

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("suppltick_entries.json")
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([LogEntry].self, from: data) else {
            entries = Self.seedData()
            save()
            return
        }
        entries = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        try? data.write(to: fileURL)
    }

    func add(_ entry: LogEntry) {
        entries.insert(entry, at: 0)
        save()
    }

    func update(_ entry: LogEntry) {
        guard let idx = entries.firstIndex(where: { $0.id == entry.id }) else { return }
        entries[idx] = entry
        save()
    }

    func delete(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
        save()
    }

    func delete(_ entry: LogEntry) {
        entries.removeAll { $0.id == entry.id }
        save()
    }

    var canAddMoreFree: Bool {
        entries.count < Self.freeLimit
    }

    static func seedData() -> [LogEntry] {
        [
        LogEntry(title: "Vitamin D", date: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(), value1: 1, value2: 8, notes: "With breakfast"),
        LogEntry(title: "Magnesium", date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), value1: 2, value2: 21, notes: "Before bed"),
        LogEntry(title: "Fish oil", date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), value1: 1, value2: 8, notes: "With breakfast")
        ]
    }
}
