import Foundation
import Vapor
import Fluent

final class Subject: Content, Model {
    static let schema = "subjects"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "subject_name")
    var subjectName: String
    
    init() { }
    
    init(id: UUID? = nil, subjectName: String) {
        self.id = id
        self.subjectName = subjectName
    }
}
