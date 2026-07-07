import SwiftUI

/// Unique palette for Comicbox: pulp yellow-ink.
enum Theme {
    static let accent = Color(hex: "#F2B705")
    static let background = Color(hex: "#111015")
    static let surface = Color(hex: "#1C1A22")
    static let textPrimary = Color(hex: "#F5F0E8")
    static let textMuted = Color(hex: "#A79F87")

    static let titleFont = Font.system(.largeTitle, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded).weight(.semibold)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}

extension Color {
    init(hex: String) {
        let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: h).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
