
// MARK: - Student
struct Student: Codable {
    let id: String
    let schoolClassId: String
    let password, photo: String
    let dateOfBirth: String
    let name, login: String
}

typealias Students = [Student]

