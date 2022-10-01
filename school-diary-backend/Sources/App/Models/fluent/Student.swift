import Foundation
import Vapor
import Fluent

final class Student: Content, Model {
    static let schema = "students"
    
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
    
    @Field(key: "school_class_id")
    var schoolClassId: UUID
    
    init() { }
    
    init(id: UUID? = nil, name: String, photo: String? = nil, login: String, password: String, dateOfBirth: String, schoolClassID: UUID) {
        self.id = id
        self.name = name
        self.photo = photo
        self.login = login
        self.password = password
        self.dateOfBirth = dateOfBirth
        self.schoolClassId = schoolClassID
    }
}
