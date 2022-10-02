import Foundation
import Alamofire
import Bond

class StudentViewViewModel: UserViewViewModelProtocol {
    private var student: UserProtocol
    var marks = MutableObservableArray<Mark>([])
    
    init(student: UserProtocol) {
        self.student = student
    }
    
    func getUser() -> UserProtocol {
        self.student
    }
    
    func isBirthdayNow() -> Bool {
        isBirthday(strDate: self.student.dateOfBirth)
    }
    
    func getMarks() {
        NetworkManager.shared.getData(with: "/\(student.id)", routeString: .marksForStudents, dataType: Mark.self) { marks in
            self.marks.removeAll()
            self.marks.insert(contentsOf: marks, at: 0)
        }
    }
}
