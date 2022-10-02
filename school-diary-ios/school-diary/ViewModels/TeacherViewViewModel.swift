import Foundation
import Alamofire
import Bond

class TeacherViewViewModel: UserViewViewModelProtocol {
    private var teacher: UserProtocol
    var marks = MutableObservableArray<Mark>([])
    
    init(teacher: UserProtocol) {
        self.teacher = teacher
    }
    
    func getUser() -> UserProtocol {
        self.teacher
    }
    
    func isBirthdayNow() -> Bool {
        isBirthday(strDate: self.teacher.dateOfBirth)
    }
    
    func getMarks() {
        NetworkManager.shared.getData(with: "/\(teacher.id)", routeString: .marksForTeachers, dataType: Mark.self) { marks in
            self.marks.removeAll()
            self.marks.insert(contentsOf: marks, at: 0)
        }
    }
    
    func deleteMark(vc: UIViewController, index: Int) {
        NetworkManager.shared.delMark(mark: marks[index], routeString: .marks) { errorText in
            if errorText == nil {
                self.marks.remove(at: index)
            } else {
                errorAlert(viewController: vc, title: "Помилка",  message: errorText!)
            }
        }
        
    }
}
