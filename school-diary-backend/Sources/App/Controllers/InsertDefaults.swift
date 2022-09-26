import Foundation
import Vapor

struct InsertSamples {
    let app: Application
    let sampleVaules = SampleValues()
    
    private func insertSchoolClasses() async throws -> String {
        do {
            if try await SchoolClass.query(on: app.db).count() == 0 {
                for schoolClass in sampleVaules.getSchoolClasses() {
                    try await schoolClass.create(on: app.db)
                }
                return "Заповнення таблиці SchoolClasses пройшло успішно."
            } else {
                return "Таблиця SchoolClasses вже заповнена."
            }
        } catch {
            return "SchoolClassess error - \(error)"
        }
    }
    
    private func insertSubjects() async throws -> String {
        do {
            if try await Subject.query(on: app.db).count() == 0 {
                for subject in sampleVaules.getSubjects() {
                    try await subject.create(on: app.db)
                }
                return "Заповнення таблиці Subjects пройшло успішно."
            } else {
                return "Таблиця Subjects вже заповнена."
            }
        } catch {
            return "Subjects error - \(error)"
        }
    }
    
    private func insertTeachers() async throws -> String {
        do {
            if try await Teacher.query(on: app.db).count() == 0 {
                for teacher in try sampleVaules.getTeachers() {
                    try await teacher.create(on: app.db)
                }
                return "Заповнення таблиці Teachers пройшло успішно."
            } else {
                return "Таблиця Teachers вже заповнена."
            }
        } catch {
            return "Teachers error - \(error)"
        }
    }
    
    private func insertStudents() async throws -> String {
        do {
            if try await Student.query(on: app.db).count() == 0 {
                let schoolClasses = try await SchoolClass.query(on: app.db).all()
                for student in try sampleVaules.getStudents1(schoolClassId: schoolClasses[schoolClasses.count - 1].id!) {
                    try await student.create(on: app.db)
                }
                for student in try sampleVaules.getStudents2(schoolClassId: schoolClasses[schoolClasses.count - 2].id!) {
                    try await student.create(on: app.db)
                }
                return "Заповнення таблиці Students пройшло успішно."
            } else {
                return "Таблиця Students вже заповнена."
            }
        } catch {
            return "Students error - \(error)"
        }
    }
    
    private func insertMarks() async throws -> String {
        do {
            if try await Mark.query(on: app.db).count() == 0 {
                let subjects = try await Subject.query(on: app.db).all()
                let teachers = try await Teacher.query(on: app.db).all()
                let students = try await Student.query(on: app.db).all()
                
                for _ in 1...5 {
                    let mark = sampleVaules.getMark(subjectId: subjects[Int.random(in: 0...subjects.count - 1)].id!, studentId: students.first!.id!, teacherId: teachers.first!.id!)
                    try await mark.create(on: app.db)
                }
                for _ in 1...6 {
                    let mark = sampleVaules.getMark(subjectId: subjects[Int.random(in: 0...subjects.count - 1)].id!, studentId: students.last!.id!, teacherId: teachers.last!.id!)
                    try await mark.create(on: app.db)
                }

                return "Заповнення таблиці Marks пройшло успішно."
            } else {
                return "Таблиця Marks вже заповнена."
            }
        } catch {
            return "Marks error - \(error)"
        }
    }
    
    func insertSampleValues() async throws -> [String] {
        var response: [String] = []
        var result: String = ""
        
        result = try await insertSchoolClasses()
        response.append(result)
        
        result = try await insertSubjects()
        response.append(result)
        
        result = try await insertTeachers()
        response.append(result)
        
        result = try await insertStudents()
        response.append(result)
        
        result = try await insertMarks()
        response.append(result)
        
        return response
    }
}
