import Foundation
import Vapor
import Fluent

final class SchoolClass: Content, Model {
    static let schema = "school_classes"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "class_name")
    var className: String
    
    @Children(for: \.$schoolClass)
    var students: [Student]
    
    init() { }
    
    init(id: UUID? = nil, className: String) {
        self.id = id
        self.className = className
    }
}
