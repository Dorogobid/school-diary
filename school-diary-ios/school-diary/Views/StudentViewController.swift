import UIKit
import Alamofire
import Lottie

class StudentViewController: UIViewController {
    private let rowHeight = 85.0
    let tableView = UITableView()
    
    var viewModel: UserViewViewModelProtocol!
    var marks: Marks = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setObservers()
        prepareUI()
        viewModel.getMarks()
    }
    
    func setObservers() {
        _ = viewModel.marks.observeNext { [weak self] marksList in
            guard let self else { return }
            self.marks = marksList.collection
            self.tableView.reloadData()
        }
    }
    
    func prepareUI() {
        view.backgroundColor = .white
        let topView = UserDetailsView()
        topView.viewModel = UserDetailsViewViewModel(user: viewModel.getUser(), userType: .student)
        topView.prepareUI()

        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(425)
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
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(topView).inset(425)
            make.bottom.equalToSuperview()
        }
        
        if viewModel.isBirthdayNow() {
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
    
    @objc func quitButtonPressed() {
        dismiss(animated: true)
    }
}

extension StudentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        marks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MarkTableViewCell()
        cell.mark = marks[indexPath.row]
        cell.initialize(userType: .student)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }
}

extension StudentViewController: UITableViewDelegate {}
