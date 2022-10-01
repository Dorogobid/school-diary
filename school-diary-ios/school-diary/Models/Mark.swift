import Foundation

// MARK: - Mark
struct Mark: Codable {
    let id: String
    let mark: Int
    let teacherName: String
    let studentId: String
    let subjectName: String
    let studentName: String
    let subjectId: String
    let markDate: String
    let teacherId: String
}

struct MarkRequest: Codable {
    let mark: Int
    let studentId: String
    let subjectId: String
    let markDate: String
    let teacherId: String
}

typealias Marks = [Mark]

//// MARK: - SubjectId
//struct SubjectId: Codable {
//    let id: String
//}
//
//// MARK: - StudentId
//struct StudentId: Codable {
//    let id: String
//}
//
//// MARK: - TeacherId
//struct TeacherId: Codable {
//    let id: String
//}

