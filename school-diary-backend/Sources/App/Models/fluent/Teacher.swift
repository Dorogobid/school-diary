import Foundation
import Vapor
import Fluent

final class Teacher: Content, Model {
    static let schema = "teachers"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @OptionalField(key: "photo")
    var photo: String?
    
    @Field(key: "login")
    var login: String
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "date_of_birth")
    var dateOfBirth: String
    
    init() { }
    
    init(id: UUID? = nil, name: String, photo: String? = nil, login: String, password: String, dateOfBirth: String) {
        self.id = id
        self.name = name
        self.photo = photo
        self.login = login
        self.password = password
        self.dateOfBirth = dateOfBirth
    }
}
