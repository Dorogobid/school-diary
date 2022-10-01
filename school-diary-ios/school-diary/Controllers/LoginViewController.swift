import UIKit
import SnapKit
import Alamofire
import CryptoKit

class LoginViewController: UIViewController {
    lazy var loginText = UITextField()
    lazy var passwordText = UITextField()
    lazy var teacherOrStudent = UISegmentedControl(items: ["👩‍🏫 Вчитель", "🙋‍♂️ Учень"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        let image = UIImageView(image: UIImage(named: "login_background"))
        image.contentMode = .scaleToFill
        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        let loginView = UIView()
        loginView.backgroundColor = .lightGray
        loginView.layer.opacity = 0.95
        loginView.layer.cornerRadius = 20
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.centerY.equalTo(self.view).offset(-100)
            make.left.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(250)
        }
        
        teacherOrStudent.selectedSegmentTintColor = .systemBlue
        teacherOrStudent.selectedSegmentIndex = 0
        loginView.addSubview(teacherOrStudent)
        teacherOrStudent.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.width.equalToSuperview().inset(16)
        }
        
        let loginLabel = UILabel()
        loginLabel.text = "Введіть логін:"
        loginView.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(teacherOrStudent).inset(34)
        }
        
        loginText.placeholder = "логін"
        loginText.borderStyle = .roundedRect
        loginText.autocapitalizationType = .none
        loginView.addSubview(loginText)
        loginText.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(loginLabel).inset(25)
            make.width.equalToSuperview().inset(16)
        }
        
        let passwordLabel = UILabel()
        passwordLabel.text = "Введіть пароль:"
        loginView.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(loginText).inset(45)
        }
        
        passwordText.placeholder = "пароль"
        passwordText.borderStyle = .roundedRect
        passwordText.isSecureTextEntry = true
        loginView.addSubview(passwordText)
        passwordText.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(passwordLabel).inset(25)
            make.width.equalToSuperview().inset(16)
        }
        
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Вхід", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 10
        loginView.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.centerX.equalTo(loginView)
            make.top.equalTo(passwordText).inset(45)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        loginText.text = "teacher1"
        passwordText.text = "teacher1"
    }
    
    @objc func loginButtonPressed() {
        var userType: UserType = .teacher
        if teacherOrStudent.selectedSegmentIndex == 1 {
            userType = .student
        }
        if loginText.text == nil || loginText.text == "" || passwordText.text == nil || passwordText.text == "" {
            errorAlert(viewController: self, title: "Помилка",  message: "Введіть дані для входу!")
            return
        }
        NetwordManager.shared.login(userType: userType.rawValue, userName: loginText.text!, password: passwordText.text!, completed: { allowLogin in
            if allowLogin && userType == .teacher {
                NetwordManager.shared.getData(with: "/" + self.loginText.text!, routeString: .teachers, dataType: Teacher.self) { teachers in
                    let teacherViewController = TeacherViewController()
                    teacherViewController.modalPresentationStyle = .fullScreen
                    teacherViewController.teacher = teachers.first
                    self.show(teacherViewController, sender: nil)
                }
            } else if allowLogin && userType == .student {
                NetwordManager.shared.getData(with: "/" + self.loginText.text!, routeString: .students, dataType: Student.self) { students in
                    let studentViewController = StudentViewController()
                    studentViewController.modalPresentationStyle = .fullScreen
                    studentViewController.student = students.first
                    self.show(studentViewController, sender: nil)
                }
            } else {
                errorAlert(viewController: self, title: "Помилка",  message: "Такого користувача не знайдено або неправильний пароль")
                return
            }
        })
    }
}

