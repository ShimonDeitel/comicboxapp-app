import Foundation

struct IssueItem: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var series: String
    var grade: String
    var notes: String = ""
    var dateAdded: Date = Date()
}
