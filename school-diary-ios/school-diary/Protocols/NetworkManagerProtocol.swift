import UIKit

protocol NetworkManagerProtocol {
    static var shared : NetworkManagerProtocol { get }
    
    func getData<T:Codable>(with id: String, routeString: RouteString, dataType: T.Type, completed: @escaping ([T]) -> Void)
    func login(userType: String, userName: String, password: String, completed: @escaping (Bool) -> Void)
    func getImage(imageName: String, routeString: RouteString, completed: @escaping (UIImage) -> Void)
    func addMark(mark: MarkRequest, routeString: RouteString)
    func delMark(mark: Mark, routeString: RouteString)
}
