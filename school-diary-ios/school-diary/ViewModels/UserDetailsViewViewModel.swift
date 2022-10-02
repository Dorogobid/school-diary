import UIKit

class UserDetailsViewViewModel: UserDetailsViewViewModelProtocol {
    private var user: UserProtocol
    let userType: UserType
    
    var userName: String {
        user.name
    }
    
    var dateOfBirth: String {
        "Дата народження: \(user.dateOfBirth)"
    }
    
    init(user: UserProtocol, userType: UserType) {
        self.user = user
        self.userType = userType
    }
    
    func getSchoolClass(completionBlock: @escaping (String) -> ()) {
        if userType == .student {
            let student = user as! Student
            NetworkManager.shared.getData(with: "/\(student.schoolClassId)", routeString: .schoolClasses, dataType: SchoolClass.self) { schoolClasses in
                completionBlock("Учень відвідує \(schoolClasses.first!.className) клас")
            }
        }
    }
    
    func getPhoto(completionBlock: @escaping (UIImage) -> ()) {
        NetworkManager.shared.getImage(imageName: "/" + user.photo, routeString: .images) { image in
            completionBlock(image)
        }
    }
}
