import UIKit
import SnapKit
import Alamofire

class UserDetailsView: UIView {
    let nameLabel = UILabel()
    let birthLabel = UILabel()
    
    var viewModel: UserDetailsViewViewModelProtocol! {
        didSet {
            nameLabel.text = viewModel.userName
            birthLabel.text = viewModel.dateOfBirth
        }
    }
    
    func prepareUI() {
        backgroundColor = .white
        
        let name1Label = UILabel()
        addSubview(name1Label)
        name1Label.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(self)
        }
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(name1Label).inset(20)
        }
        
        addSubview(birthLabel)
        birthLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(nameLabel).inset(26)
        }
        
        let classLabel = UILabel()
        
        addSubview(classLabel)
        classLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(birthLabel).inset(26)
        }
        
        let photoLabel = UILabel()
        photoLabel.text = "Фото:"
        addSubview(photoLabel)
        
        let photo = UIImageView()

        photo.contentMode = .scaleAspectFit
        addSubview(photo)
        photo.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(photoLabel).inset(24)
            make.height.equalTo(270)
        }
        
        viewModel.getSchoolClass { text in
            classLabel.text = text
            name1Label.text = "ПІБ учня:"
            photoLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(10)
                make.top.equalTo(classLabel).inset(24)
            }
        }
        if viewModel.userType == .teacher {
            name1Label.text = "ПІБ вчителя:"
            
            photoLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(10)
                make.top.equalTo(birthLabel).inset(24)
            }
        }
        viewModel.getPhoto { image in
            photo.image = image
        }
        
        let marksLabel = UILabel()
        marksLabel.text = "Оцінки:"
        marksLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        addSubview(marksLabel)
        marksLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(photo).inset(275)
        }
    }

}
