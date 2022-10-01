import Foundation

// MARK: - Subject
struct Subject: Codable {
    let id: String
    let subjectName: String
}

typealias Subjects = [Subject]
