import Foundation

// MARK: - Student
struct Student: Codable {
    let schoolClass: SchoolClassWOName
    let password, id, photo: String
    let dateOfBirth: String
    let name, login: String
}

typealias Students = [Student]

