import Foundation
import Vapor
import Fluent

final class Mark: Content, Model {
    static let schema = "marks"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "mark_date")
    var markDate: String
    
    @Parent(key: "subject_id")
    var subject: Subject
    
    @Parent(key: "student_id")
    var student: Student

    @Parent(key: "teacher_id")
    var teacher: Teacher
    
    @Field(key: "mark")
    var mark: Int
    
    init() { }

    init(id: UUID? = nil, markDate: String, subjectID: Subject.IDValue, studentID: Student.IDValue, teacherID: Teacher.IDValue, mark: Int) {
        self.id = id
        self.markDate = markDate
        self.$subject.id = subjectID
        self.$student.id = studentID
        self.$teacher.id = teacherID
        self.mark = mark
    }
}

final class MarkFull: Content, Model {
    static let schema = "marks"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "mark_date")
    var markDate: String
    
    @Parent(key: "subject_id")
    var subject: Subject
    
    @Parent(key: "student_id")
    var student: Student

    @Parent(key: "teacher_id")
    var teacher: Teacher
    
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
