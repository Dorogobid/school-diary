import UIKit

class AddMarkViewViewModel: AddMarkViewViewModelProtocol {
    let marks = [1,2,3,4,5,6,7,8,9,10,11,12]
    private var teacher: Teacher
    var subjects: Subjects = []
    var students: Students = []
    
    var teacherId: String {
        teacher.id
    }
    
    init(teacher: Teacher) {
        self.teacher = teacher
        getSubjects { subjects in
            self.subjects = subjects
        }
        getStudents { students in
            self.students = students
        }
    }
    
    private func getSubjects(completionBlock: @escaping (Subjects) -> ()) {
        NetworkManager.shared.getData(with: "", routeString: .subjects, dataType: Subject.self) { subjects in
            completionBlock(subjects)
        }
    }
    
    private func getStudents(completionBlock: @escaping (Students) -> ()) {
        NetworkManager.shared.getData(with: "", routeString: .students, dataType: Student.self) { students in
            completionBlock(students)
        }
    }
    
    func getMark(row: Int) -> String {
        "Оцінка - \(marks[row])"
    }
    
    func addMark(vc: UIViewController, mark: MarkRequest, completionBlock: @escaping () -> ()) {
        NetworkManager.shared.addMark(mark: mark, routeString: .marks) { errorText in
            if errorText == nil {
                completionBlock()
            } else {
                errorAlert(viewController: vc, title: "Помилка",  message: errorText!)
            }
        }
    }
}
