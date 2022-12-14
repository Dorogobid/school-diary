
struct Teacher: Codable, UserProtocol {
    let id: String
    let password, login: String
    let dateOfBirth: String
    let name, photo: String
}

typealias Teachers = [Teacher]

enum UserType: String {
    case teacher
    case student
}
