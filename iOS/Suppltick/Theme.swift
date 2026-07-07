import SwiftUI

enum Theme {
    static let accent = Color(red: 0.2902, green: 0.4196, blue: 0.5412)
    static let background = Color(red: 0.0549, green: 0.1020, blue: 0.1412)
    static let cardBackground = background.opacity(0.55)
    static let textPrimary = Color(red: 0.93, green: 0.94, blue: 0.95)
    static let textSecondary = Color(red: 0.93, green: 0.94, blue: 0.95).opacity(0.6)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}
