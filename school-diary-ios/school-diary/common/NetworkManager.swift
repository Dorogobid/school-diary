import Foundation
import Alamofire

enum RouteString: String {
    case subjects = "/api/subjects"
    case students = "/api/students"
    case teachers = "/api/teachers"
    case marks = "/api/marks"
    case marksForStudents = "/api/marks/1"
    case marksForTeachers = "/api/marks/2"
    case images = "/img"
    case schoolClasses = "/api/school_classes"
    case login = "/api/login"
}

typealias NetworkManager = NetworkManagerV1

final class NetworkManagerV1 : NetworkManagerProtocol{
    static var shared: NetworkManagerProtocol {
        NetworkManagerV1()
    }
    
    private let baseURL = "http://127.0.0.1:8080"
    private let bearerToken = "eyJhbGciOiJQUzI1NiIsInR5cCI6IkpXVCJ98Ng09a8"
    
    private init() { }
    
    func getData<T:Codable>(with id: String, routeString: RouteString, dataType: T.Type, completed: @escaping ([T]) -> Void) {
        let url = baseURL + routeString.rawValue + id
        let headers: HTTPHeaders = [.authorization(bearerToken: bearerToken)]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [T].self) { response in
            do {
                let data = try response.result.get()
                completed(data)
            } catch {
                print("Неможливо отримати дані")
            }
        }
    }
    
    func login(userType: String, userName: String, password: String, completed: @escaping (Bool) -> Void) {
        let url = baseURL + RouteString.login.rawValue
        let login = LoginData(userType: userType, userName: userName, pass: password)
        let headers: HTTPHeaders = [.authorization(bearerToken: bearerToken)]
        
        AF.request(url, method: .post, parameters: login, encoder: JSONParameterEncoder.prettyPrinted, headers: headers).response { response in
            switch response.result {
            case .success(_):
                switch response.response?.statusCode {
                case 200:
                    completed(true)
                case .none:
                    completed(false)
                case .some(_):
                    completed(false)
                }
            case .failure(_):
                completed(false)
            }
        }
    }
    
    func getImage(imageName: String, routeString: RouteString, completed: @escaping (UIImage) -> Void) {
        let url = baseURL + routeString.rawValue + imageName
        let headers: HTTPHeaders = [.authorization(bearerToken: bearerToken)]
        
        AF.request(url, headers: headers).response { response in
            guard let data = response.data, let image = UIImage(data: data) else { return }
            completed(image)
        }
    }
    
    func addMark(mark: MarkRequest, routeString: RouteString, completed: @escaping (String?) -> ()) {
        let url = baseURL + routeString.rawValue
        let headers: HTTPHeaders = [.authorization(bearerToken: bearerToken)]
        
        AF.request(url, method: .post, parameters: mark, encoder: JSONParameterEncoder.prettyPrinted, headers: headers).response { response in
            if response.response?.statusCode == 200 {
                completed(nil)
            } else {
                completed("Помилка при додаванні данних")
            }
        }
    }
    
    func delMark(mark: Mark, routeString: RouteString, completed: @escaping (String?) -> ()) {
        let url = baseURL + routeString.rawValue
        let headers: HTTPHeaders = [.authorization(bearerToken: bearerToken)]
        
        AF.request(url, method: .delete, parameters: mark, encoder: JSONParameterEncoder.prettyPrinted, headers: headers).response { response in
            if response.response?.statusCode == 200 {
                completed(nil)
            } else {
                completed("Помилка при видаленні данних")
            }
        }
    }
}
