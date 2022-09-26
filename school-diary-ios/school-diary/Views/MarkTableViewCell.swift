import UIKit

class MarkTableViewCell: UITableViewCell {
    var mark: Mark?

    override func awakeFromNib() {
        super.awakeFromNib()
//        initialize()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func initialize(userType: UserType) {
        let view = UIView()
        let nameLabel = UILabel()
        let markLabel = UILabel()
        let subjectLabel = UILabel()
        let dateLabel = UILabel()
        
        view.layer.cornerRadius = 30
        view.backgroundColor = .lightGray
        view.layer.opacity = 0.8
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(3)
        }
        
        markLabel.text = "\(mark!.mark)"
        markLabel.font = UIFont.boldSystemFont(ofSize: 35)
        markLabel.textAlignment = .center
//        markLabel.backgroundColor = .gray
        contentView.addSubview(markLabel)
        markLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.width.height.equalTo(50)
        }
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        if userType == .student {
            nameLabel.text = mark!.teacherName
        } else {
            nameLabel.text = mark!.studentName
        }
        
//        nameLabel.backgroundColor = .cyan
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(markLabel).inset(58)
            make.top.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
        }
        
        subjectLabel.text = "Предмет: \(mark!.subjectName)"
//        markLabel.font = UIFont.boldSystemFont(ofSize: 20)
//        subjectLabel.backgroundColor = .green
        contentView.addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints { make in
            make.left.equalTo(markLabel).inset(58)
            make.top.equalTo(nameLabel).inset(24)
            make.right.equalToSuperview().inset(8)
        }
        
        dateLabel.text = "Дата оцінки: \(mark!.markDate)"
        dateLabel.font = UIFont.systemFont(ofSize: 14)
//        dateLabel.backgroundColor = .green
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(markLabel).inset(58)
            make.top.equalTo(subjectLabel).inset(24)
            make.right.equalToSuperview().inset(8)
        }
    }
}
