import Foundation
import Vapor
import Fluent

final class Mark: Content, Model {
    static let schema = "marks"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "mark_date")
    var markDate: String
    
    @Field(key: "subject_id")
    var subjectId: UUID
    
    @Field(key: "student_id")
    var studentId: UUID

    @Field(key: "teacher_id")
    var teacherId: UUID
    
    @Field(key: "mark")
    var mark: Int
    
    init() { }

    init(id: UUID? = nil, markDate: String, subjectID: UUID, studentID: UUID, teacherID: UUID, mark: Int) {
        self.id = id
        self.markDate = markDate
        self.subjectId = subjectID
        self.studentId = studentID
        self.teacherId = teacherID
        self.mark = mark
    }
}

final class MarkFull: Content, Model {
    static let schema = "marks"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "mark_date")
    var markDate: String
    
    @Field(key: "subject_id")
    var subjectId: UUID
    
    @Field(key: "student_id")
    var studentId: UUID

    @Field(key: "teacher_id")
    var teacherId: UUID
    
    @Field(key: "mark")
    var mark: Int
    
    @Field(key: "subject_name")
    var subjectName: String
    
    @Field(key: "teacher_name")
    var teacherName: String
    
    @Field(key: "student_name")
    var studentName: String
    
    init() { }

}
