import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewViewModelProtocol?
    
    lazy var loginText = UITextField()
    lazy var passwordText = UITextField()
    lazy var teacherOrStudent = UISegmentedControl(items: ["👩‍🏫 Вчитель", "🙋‍♂️ Учень"])
    
    init(viewModel: LoginViewViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    func prepareUI() {
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
        if loginText.text == nil || loginText.text == "" || passwordText.text == nil || passwordText.text == "" {
            errorAlert(viewController: self, title: "Помилка",  message: "Введіть дані для входу!")
            return
        }
        
        let login = loginText.text!
        let password = passwordText.text!
        
        viewModel?.login(userTypeInt: teacherOrStudent.selectedSegmentIndex, login: login, password: password, completionBlock: { errorText, nextVC in
            if errorText != nil {
                errorAlert(viewController: self, title: "Помилка",  message: errorText!)
                return
            }
            guard let nextVC else { return }
            self.show(nextVC, sender: nil)
        })
    }
}

