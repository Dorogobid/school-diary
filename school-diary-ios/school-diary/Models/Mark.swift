import Foundation

// MARK: - Mark
struct Mark: Codable {
    let id: String
    let mark: Int
    let teacherName: String
    let student: StudentId
    let subjectName: String
    let studentName: String
    let subject: SubjectId
    let markDate: String
    let teacher: TeacherId
}

struct MarkRequest: Codable {
    let mark: Int
    let student: StudentId
    let subject: SubjectId
    let markDate: String
    let teacher: TeacherId
}

typealias Marks = [Mark]

// MARK: - SubjectId
struct SubjectId: Codable {
    let id: String
}

// MARK: - StudentId
struct StudentId: Codable {
    let id: String
}

// MARK: - TeacherId
struct TeacherId: Codable {
    let id: String
}

