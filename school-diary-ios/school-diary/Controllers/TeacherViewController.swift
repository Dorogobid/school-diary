import UIKit
import Alamofire
import Lottie

class TeacherViewController: UIViewController {
    let tableView = UITableView()
//    {
//        let table = UITableView()
//        table.register(MarkTableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }()
    
    var teacher: Teacher?
    var marks: Marks = []

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NetwordManager.shared.getData(with: teacher!.id, routeString: .marksForTeachers, dataType: Mark.self) { marks in
            self.marks = marks
            self.tableView.reloadData()
        }
    }
    
    func initialize() {
        view.backgroundColor = .white
        let topView = UserDetailsView()
        topView.userType = .teacher
        topView.teacher = teacher!
        
        topView.prepare()

        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(400)
        }
        
        let quitButton = UIButton(type: .system)
        quitButton.setTitleColor(UIColor.blue, for: .normal)
        quitButton.setTitle("Вийти", for: .normal)

        view.addSubview(quitButton)
        quitButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        quitButton.addTarget(self, action: #selector(quitButtonPressed), for: .touchUpInside)
        
        let addButton = UIButton(frame: CGRect(x: view.frame.maxX - 160, y: 410, width: 150, height: 40))
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.layer.cornerRadius = 15
        addButton.backgroundColor = .systemBlue
        addButton.setTitle("Додати оцінку", for: .normal)
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(topView).inset(410)
            make.bottom.equalToSuperview()
        }

        if isBirthday(strDate: teacher!.dateOfBirth) {
            let animation = AnimationView(name: "happy-birthday")
            animation.frame = view.bounds
            animation.contentMode = .scaleAspectFit
            animation.loopMode = .playOnce
            animation.animationSpeed = 1.5
            view.addSubview(animation)
            animation.play { _ in
                animation.removeFromSuperview()
            }
        }
    }
    
    @objc func addButtonPressed() {
        let addMarkViewController = AddMarkViewController()
        addMarkViewController.modalPresentationStyle = .fullScreen
        addMarkViewController.teacher = teacher
        showDetailViewController(addMarkViewController, sender: nil)
    }
    
    @objc func quitButtonPressed() {
        dismiss(animated: true)
    }
}
extension TeacherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        marks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MarkTableViewCell()//tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MarkTableViewCell
        cell.mark = marks[indexPath.row]
        cell.initialize(userType: .teacher)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
}

extension TeacherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _, _, completion in
            NetwordManager.shared.delMark(mark: self.marks[indexPath.row], routeString: .marks)
            self.marks.remove(at: indexPath.row)
            self.tableView.reloadData()
            completion(true)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
