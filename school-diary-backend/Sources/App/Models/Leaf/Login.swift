import Foundation
import Vapor

struct LoginData: Content {
    var userType: String?
    var userName: String?
    var pass: String?
    var submit: String?
}

