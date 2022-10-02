import UIKit

protocol UserDetailsViewViewModelProtocol {
    var userType: UserType { get }
    var userName: String { get }
    var dateOfBirth: String { get }
    func getSchoolClass(completionBlock: @escaping (String) -> ())
    func getPhoto(completionBlock: @escaping (UIImage) -> ())
}
