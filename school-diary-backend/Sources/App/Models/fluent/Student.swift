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
    
    @Parent(key: "school_class_id")
    var schoolClass: SchoolClass
    
    init() { }
    
    init(id: UUID? = nil, name: String, photo: String? = nil, login: String, password: String, dateOfBirth: String, schoolClassID: SchoolClass.IDValue) {
        self.id = id
        self.name = name
        self.photo = photo
        self.login = login
        self.password = password
        self.dateOfBirth = dateOfBirth
        self.$schoolClass.id = schoolClassID
    }
}

//final class Student2: Content, Model{
//    static let schema = "students"
//
//    @ID(key: .id)
//    var id: UUID?
//
//    @Field(key: "name")
//    var name: String
//
//    @OptionalField(key: "photo")
//    var photo: String?
//
//    @Field(key: "login")
//    var login: String
//
//    @Field(key: "password")
//    var password: String
//
//    @Field(key: "date_of_birth")
//    var dateOfBirth: String
//
//    @Parent(key: "school_class_id")
//    var schoolClass: SchoolClass
//
//    @Field(key: "school_class_name")
//    var schoolClassName: String
//
//    init() { }
//
////    init(id: UUID? = nil, name: String, photo: String? = nil, login: String, password: String, dateOfBirth: String, schoolClassID: SchoolClass.IDValue) {
////        self.id = id
////        self.name = name
////        self.photo = photo
////        self.login = login
////        self.password = password
////        self.dateOfBirth = dateOfBirth
////        self.$schoolClass.id = schoolClassID
////    }
//}
