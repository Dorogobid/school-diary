import UIKit
import SnapKit
import Alamofire

class UserDetailsView: UIView {
    
    var student: Student?
    var teacher: Teacher?
    var userType: UserType = .teacher
    
    
    func prepare() {
        backgroundColor = .white
        
        let name1Label = UILabel()
        addSubview(name1Label)
        name1Label.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(self)
        }
        
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(name1Label).inset(20)
        }
        
        let birthLabel = UILabel()
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
        
        if userType == .student {
            name1Label.text = "ПІБ учня:"
            nameLabel.text = student?.name
            birthLabel.text = "Дата народження: \(student!.dateOfBirth)"
            
            NetworkManager.shared.getData(with: "/\(student!.schoolClassId)", routeString: .schoolClasses, dataType: SchoolClass.self) { schoolClasses in
                classLabel.text = "Учень відвідує \(schoolClasses.first!.className) клас"
            }
            
            photoLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(10)
                make.top.equalTo(classLabel).inset(24)
            }
            NetworkManager.shared.getImage(imageName: "/" + student!.photo, routeString: .images) { image in
                photo.image = image
            }
        } else {
            name1Label.text = "ПІБ вчителя:"
            nameLabel.text = teacher?.name
            birthLabel.text = "Дата народження: \(teacher!.dateOfBirth)"
            
            photoLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(10)
                make.top.equalTo(birthLabel).inset(24)
            }
            
            NetworkManager.shared.getImage(imageName: "/" + teacher!.photo, routeString: .images) { image in
                photo.image = image
            }
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
