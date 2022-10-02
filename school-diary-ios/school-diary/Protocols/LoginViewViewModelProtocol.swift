import UIKit

protocol LoginViewViewModelProtocol {
    func login(userTypeInt: Int, login: String, password: String, completionBlock: @escaping (String?, UIViewController?) -> ())
}
