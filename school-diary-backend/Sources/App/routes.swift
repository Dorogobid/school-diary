import Fluent
import FluentSQL
import Vapor

func routes(_ app: Application) throws {

    //MARK: http
    // POST /login
    app.post("login") { req async throws -> View in
        let login = try req.content.decode(LoginData.self)
        print(login)
        if login.userType == "teacher" {
            let teachers = try await Teacher.query(on: req.db)
                .filter(\.$login == login.userName!)
                .filter(\.$password == hashStr(login.pass!))
                .all()
            if teachers.count > 0 {
                let teacher = teachers.first!
                var marks: [MarkFull] = []
                if let sql = req.db as? SQLDatabase {
                    do {
                        let sqlText = SQLQueryString("SELECT m.*, s.subject_name as subject_name, t.name as teacher_name, st.name as student_name FROM marks as m, subjects as s, teachers t, students st where s.id = m.subject_id and t.id = m.teacher_id and m.student_id=st.id and teacher_id = '" + String(teacher.id!) + "'")
                        
                        marks = try await sql.raw(sqlText).all(decoding: MarkFull.self)
                        
                    } catch {
                        print(error)
                    }
                } else {
                }
                var teacherContext = LeafContext(userType: "teacher", name: teacher.name, className: "", photo: teacher.photo!, dateOfBirth: teacher.dateOfBirth)
                for mark in marks {
                    teacherContext.marksText.append(mark)
                }

                return try await req.view.render("detail", teacherContext)
            }
        }
        else if login.userType == "student" {
            let students =  try await Student.query(on: req.db)
                .filter(\.$login == login.userName!)
                .filter(\.$password == hashStr(login.pass!))
                .all()
            if students.count > 0 {
                let student = students.first!
                var marks: [MarkFull] = []
                let schoolClasses = try await SchoolClass.query(on: req.db)
                    .filter(\.$id == student.$schoolClass.id)
                    .all()
                if let sql = req.db as? SQLDatabase {
                    do {
                        let sqlText = SQLQueryString("SELECT m.*, s.subject_name as subject_name, t.name as teacher_name, st.name as student_name FROM marks as m, subjects as s, teachers t, students st where s.id = m.subject_id and t.id = m.teacher_id and m.student_id=st.id and student_id = '" + String(student.id!) + "'")
                        
                        marks = try await sql.raw(sqlText).all(decoding: MarkFull.self)
                        
                    } catch {
                        print(error)
                    }
                } else {
                }
                var studentContext = LeafContext(userType: "student", name: student.name, className: "\(schoolClasses.first!.className) клас", photo: student.photo!, dateOfBirth: student.dateOfBirth)
                for mark in marks {
                    
                    studentContext.marksText.append(mark)
                }

                return try await req.view.render("detail", studentContext)
            }
        }
        return try await req.view.render("NoSuchUser")
    }
    
    //MARK: group routes
    let api = app.grouped(UserAuthenticator()).grouped("api")
    
    //MARK: login
    // POST /api/login
    api.post("login") { req async throws in
        do {
            let _ = try req.auth.require(ApiUser.self)
            let login = try req.content.decode(LoginData.self)
            print(login)
            if login.userType == "teacher" {
                let teacher = try await Teacher.query(on: req.db)
                    .filter(\.$login == login.userName!)
                    .filter(\.$password == hashStr(login.pass!))
                    .all()
                if teacher.count > 0 {
                    return HTTPStatus.ok
                }
            } else if login.userType == "student" {
                let students =  try await Student.query(on: req.db)
                    .filter(\.$login == login.userName!)
                    .filter(\.$password == hashStr(login.pass!))
                    .all()
                if students.count > 0 {
                    return HTTPStatus.ok
                }
            }
            return HTTPStatus.forbidden
        } catch {
            return HTTPStatus.forbidden
        }
    }
    
    
    //MARK: Samples
    // GET /api/samples
    api.get("samples") { req async -> [String] in
        let insertSamples = InsertSamples(app: app)
        
        do {
            return try await insertSamples.insertSampleValues()
        } catch {
            return ["\(error)"]
        }
    }
    
    
    
    
    //MARK: Subjects
    // GET /api/subjects
    api.get("subjects") { req async throws in
        do {
            let _ = try req.auth.require(ApiUser.self)
            return try await Subject.query(on: req.db).all()
        } catch {
            return []
        }
    }
    
    
    
    
    //MARK: Teachers
    // GET /api/teachers/:teacherLogin
    api.get("teachers", ":teacherLogin") { req async throws -> [Teacher] in
        do {
            let _ = try req.auth.require(ApiUser.self)
            return try await Teacher.query(on: req.db)
                .filter(\.$login == req.parameters.get("teacherLogin")!)
                .all()
        } catch {
            return []
        }
    }
    
    
    
    
    //MARK: SchoolClasses
    // GET /api/schoolclasses/:ID
    api.get("school_classes", ":ID") { req async throws in
        do {
            let _ = try req.auth.require(ApiUser.self)
            return try await SchoolClass.query(on: req.db)
            .filter(\.$id == req.parameters.get("ID")!)
            .all()
        } catch {
            return []
        }
    }
    
    
    
    
    //MARK: Marks
    // GET /api/marks/1/:studentID
    api.get("marks", "1", ":studentID") { req async -> [MarkFull] in
        do {
            let _ = try req.auth.require(ApiUser.self)
            var marks: [MarkFull] = []
            if let sql = req.db as? SQLDatabase {
                do {
                    let sqlText = SQLQueryString("SELECT m.*, s.subject_name as subject_name, t.name as teacher_name, st.name as student_name FROM marks as m, subjects as s, teachers t, students st where s.id = m.subject_id and t.id = m.teacher_id and m.student_id=st.id and student_id = '" + req.parameters.get("studentID")! + "'")
                    marks = try await sql.raw(sqlText).all(decoding: MarkFull.self)
                    
                } catch {
                    print(error)
                }
            } else {
            }
            return marks
        } catch {
            return []
        }
    }
    
    // GET /api/marks/1/:teacherID
    api.get("marks", "2", ":teacherID") { req async -> [MarkFull] in
        do {
            let _ = try req.auth.require(ApiUser.self)
            var marks: [MarkFull] = []
            if let sql = req.db as? SQLDatabase {
                do {
                    let sqlText = SQLQueryString("SELECT m.*, s.subject_name as subject_name, t.name as teacher_name, st.name as student_name FROM marks as m, subjects as s, teachers t, students st where s.id = m.subject_id and t.id = m.teacher_id and m.student_id=st.id and teacher_id = '" + req.parameters.get("teacherID")! + "'")
                    marks = try await sql.raw(sqlText).all(decoding: MarkFull.self)
                    
                } catch {
                    print(error)
                }
            } else {
            }
            return marks
        } catch {
            return []
        }
    }
    
    // POST /api/marks
    api.post("marks") { req async throws -> Mark in
        do {
            let _ = try req.auth.require(ApiUser.self)
            let mark = try req.content.decode(Mark.self)
            try await mark.create(on: req.db)
            return mark
        } catch {
            return Mark()
        }
    }
    
    // DELETE /api/marks
    api.delete("marks") { req async throws -> Mark in
        do {
            let _ = try req.auth.require(ApiUser.self)
            let mark = try req.content.decode(Mark.self)
            try await mark.delete(on: req.db)
            return mark
        } catch {
            return Mark()
        }
    }
    
    
    
    
    //MARK: Students
    // GET /api/students
    api.get("students") { req async throws -> [Student] in
        do {
            let _ = try req.auth.require(ApiUser.self)
            let students = try await Student.query(on: req.db).all()
            return students
        } catch {
            return []
        }
    }
    
    // GET /api/students/studentLogin
    api.get("students", ":studentLogin") { req async throws -> [Student] in
        do {
            let _ = try req.auth.require(ApiUser.self)
            return try await Student.query(on: req.db)
                .join(SchoolClass.self, on: \Student.$schoolClass.$id == \SchoolClass.$id)
                .filter(\.$login == req.parameters.get("studentLogin")!)
                .all()
        } catch {
            return []
        }
    }
}
