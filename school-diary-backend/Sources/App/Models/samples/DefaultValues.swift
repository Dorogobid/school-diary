import Foundation
import Vapor


class SampleValues {
    func getSchoolClasses() -> [SchoolClass] {
        let schoolClass1 = SchoolClass(className: "1-А")
        let schoolClass2 = SchoolClass(className: "2-А")
        let schoolClass3 = SchoolClass(className: "3-А")
        let schoolClass4 = SchoolClass(className: "4-А")
        let schoolClass5 = SchoolClass(className: "5-А")
        let schoolClass6 = SchoolClass(className: "6-А")
        let schoolClass7 = SchoolClass(className: "7-А")
        let schoolClass8 = SchoolClass(className: "8-А")
        let schoolClass9 = SchoolClass(className: "9-А")
        let schoolClass10 = SchoolClass(className: "10-А")
        let schoolClass11 = SchoolClass(className: "11-А")
        let schoolClass12 = SchoolClass(className: "11-Б")
        let schoolClass13 = SchoolClass(className: "11-В")
        
        return [schoolClass1, schoolClass2, schoolClass3, schoolClass4, schoolClass5, schoolClass6, schoolClass7, schoolClass8, schoolClass9, schoolClass10, schoolClass11, schoolClass12, schoolClass13]
    }
    
    func getSubjects() -> [Subject] {
        let subject1 = Subject(subjectName: "Українська мова")
        let subject2 = Subject(subjectName: "Українська література")
        let subject3 = Subject(subjectName: "Математика")
        let subject4 = Subject(subjectName: "Історія")
        let subject5 = Subject(subjectName: "Географія")
        let subject6 = Subject(subjectName: "Іноземна мова")
        
        return [subject1, subject2, subject3, subject4, subject5, subject6]
    }
    
    func getTeachers() throws -> [Teacher] {
        let teacher1 = Teacher(name: "Девід Гарбор", photo: "teacher1.jpeg", login: "teacher1", password: hashStr("teacher1"), dateOfBirth: "1988-09-10")
        let teacher2 = Teacher(name: "Вайнона Райдер", photo: "teacher2.jpeg", login: "teacher2", password: hashStr("teacher2"), dateOfBirth: "1976-10-14")
        
        return [teacher1, teacher2]
    }
    
    func getStudents1(schoolClassId: UUID) throws -> [Student] {
        let student1 = Student(name: "Міллі Боббі Браун", photo: "student1.jpeg", login: "student1", password: hashStr("student1"), dateOfBirth: "2004-09-11", schoolClassID: schoolClassId)
        let student2 = Student(name: "Фінн Вулфгард", photo: "student2.jpeg", login: "student2", password: hashStr("student2"), dateOfBirth: "2002-12-23", schoolClassID: schoolClassId)
        let student3 = Student(name: "Калеб Маклафлін", photo: "student3.jpeg", login: "student3", password: hashStr("student3"), dateOfBirth: "2001-10-13", schoolClassID: schoolClassId)
        let student4 = Student(name: "Ноа Шнапп", photo: "student4.jpeg", login: "student4", password: hashStr("student4"), dateOfBirth: "2004-10-03", schoolClassID: schoolClassId)
        
        return [student1, student2, student3, student4]
    }
    
    func getStudents2(schoolClassId: UUID) throws -> [Student] {
        let student5 = Student(name: "Седі Сінк", photo: "student5.jpeg", login: "student5", password: hashStr("student5"), dateOfBirth: "2002-04-16", schoolClassID: schoolClassId)
        let student6 = Student(name: "Гейтен Матараццо", photo: "student6.jpeg", login: "student6", password: hashStr("student6"), dateOfBirth: "2002-09-08", schoolClassID: schoolClassId)

        return [student5, student6]
    }
    
    func getMark(subjectId: UUID, studentId: UUID, teacherId: UUID) -> Mark {
        Mark(markDate: dateToString(date: Date()), subjectID: subjectId, studentID: studentId, teacherID: teacherId, mark: Int.random(in: 5...12))
    }

}


