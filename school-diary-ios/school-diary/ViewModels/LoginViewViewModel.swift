import UIKit
import Alamofire

class LoginViewViewModel: LoginViewViewModelProtocol{
    func login(userTypeInt: Int, login: String, password: String, completionBlock: @escaping (String?, UIViewController?) -> ()) {
        var userType: UserType = .teacher
        if userTypeInt == 1 { userType = .student}
        
        NetworkManager.shared.login(userType: userType.rawValue, userName: login, password: password, completed: { allowLogin in
            if allowLogin && userType == .teacher {
                NetworkManager.shared.getData(with: "/" + login, routeString: .teachers, dataType: Teacher.self) { teachers in
                    let teacherViewController = TeacherViewController()
                    teacherViewController.modalPresentationStyle = .fullScreen
                    teacherViewController.viewModel = TeacherViewViewModel(teacher: teachers.first!)
                    completionBlock(nil, teacherViewController)
                }
            } else if allowLogin && userType == .student {
                NetworkManager.shared.getData(with: "/" + login, routeString: .students, dataType: Student.self) { students in
                    let studentViewController = StudentViewController()
                    studentViewController.modalPresentationStyle = .fullScreen
                    studentViewController.viewModel = StudentViewViewModel(student: students.first!)
                    completionBlock(nil, studentViewController)
                }
            } else {
                completionBlock("Такого користувача не знайдено або неправильний пароль", nil)
            }
        })
    }
}
