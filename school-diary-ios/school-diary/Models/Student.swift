import Foundation

// MARK: - Student
struct Student: Codable {
    let id: String
    let schoolClass: SchoolClassWOName
    let password, photo: String
    let dateOfBirth: String
    let name, login: String
}

typealias Students = [Student]

