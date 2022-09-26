import UIKit
import Alamofire

class AddMarkViewController: UIViewController {
    lazy var datePicker = UIDatePicker()
    lazy var subjectPicker = UIPickerView()
    lazy var studentPicker = UIPickerView()
    lazy var markPicker = UIPickerView()
    
    var teacher: Teacher?
    var subjects: Subjects = []
    var students: Students = []
    var marks = [1,2,3,4,5,6,7,8,9,10,11,12]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    func initialize() {
        view.backgroundColor = .white
        
        let topView = UIView()
//                topView.backgroundColor = .lightGray
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)//.inset(16)
            make.left.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(800)
        }
        
        let dateLabel = UILabel()
        dateLabel.text = "Дата оцінки:"
        topView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(8)
        }
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        topView.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(dateLabel).inset(8)
            make.height.equalTo(150)
        }
        
        let subjectLabel = UILabel()
        subjectLabel.text = "Предмет:"
        topView.addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.top.equalTo(datePicker).inset(150)
        }
        
        subjectPicker.dataSource = self
        subjectPicker.delegate = self
        subjectPicker.tag = 0
        topView.addSubview(subjectPicker)
        
        NetwordManager.shared.getData(with: "", routeString: .subjects, dataType: Subject.self) { subjects in
//        NetwordManager.shared.getAllSubjects { subjects in
            self.subjects = subjects
            self.subjectPicker.reloadAllComponents()
        }
        
        subjectPicker.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(subjectLabel).inset(8)
            make.height.equalTo(150)
        }
        
        let studentLabel = UILabel()
        studentLabel.text = "ПІБ учня:"
        topView.addSubview(studentLabel)
        studentLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.top.equalTo(subjectPicker).inset(150)
        }
        
        studentPicker.dataSource = self
        studentPicker.delegate = self
        studentPicker.tag = 1
        topView.addSubview(studentPicker)
        
        NetwordManager.shared.getData(with: "", routeString: .students, dataType: Student.self) { students in
            self.students = students
            self.studentPicker.reloadAllComponents()
        }

        studentPicker.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(studentLabel).inset(8)
            make.height.equalTo(150)
        }
        
        let markLabel = UILabel()
        markLabel.text = "Оцінка:"
        topView.addSubview(markLabel)
        markLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.top.equalTo(studentPicker).inset(150)
        }
        
        markPicker.dataSource = self
        markPicker.delegate = self
        markPicker.tag = 2
        markPicker.selectRow(11, inComponent: 0, animated: false)
        topView.addSubview(markPicker)
        markPicker.reloadAllComponents()
        
        markPicker.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(markLabel).inset(8)
            make.height.equalTo(150)
        }
        
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.layer.cornerRadius = 15
//        cancelButton.borde
        cancelButton.backgroundColor = .lightGray
        cancelButton.setTitle("Відмінити", for: .normal)
//        cancelButton.setTitleColor(.black, for: .normal)
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(50)
            make.top.equalTo(markPicker).inset(160)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        let addButton = UIButton(type: .system)
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.layer.cornerRadius = 15
        addButton.backgroundColor = .systemBlue
        addButton.setTitle("Додати", for: .normal)
//        addButton.setTitleColor(.black, for: .normal)
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(50)
            make.top.equalTo(markPicker).inset(160)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func addButtonPressed() {
        let mark = MarkRequest(mark: marks[markPicker.selectedRow(inComponent: 0)], student: StudentId(id: students[studentPicker.selectedRow(inComponent: 0)].id), subject: SubjectId(id: subjects[subjectPicker.selectedRow(inComponent: 0)].id), markDate: dateToString(date: datePicker.date), teacher: TeacherId(id: teacher!.id))
        
        NetwordManager.shared.addMark(mark: mark, routeString: .marks)
        dismiss(animated: true)
    }
}

extension AddMarkViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return subjects.count
        case 1:
            return students.count
        case 2:
            return marks.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return subjects[row].subjectName
        case 1:
            return students[row].name
        case 2:
            return "Оцінка - \(marks[row])"
        default:
            return ""
        }
        
    }
}
