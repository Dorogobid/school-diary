import Foundation
import UIKit
import Alamofire

func hashStr(_ str: String) -> String {
    str.data(using: .utf8)!.md5
}

func checkPassword(password: String, hash: String) -> Bool {
    hash == hashStr(password)
}

func errorAlert(viewController: UIViewController, title: String,  message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    viewController.present(alert, animated: true, completion: nil)
}

func isBirthday(strDate: String) -> Bool {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let result = formatter.date(from: strDate)
    
    guard let result = result else {
        return false
    }
    
    let currentDate = Date()
    let cal = Calendar.current
    
    if cal.dateComponents([.day, .month], from: result) == cal.dateComponents([.day, .month], from: currentDate) {
        return true
    } else {
        return false
    }
}

func dateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: date)
}

func StringToDate(str: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    let result = formatter.date(from: str)
    guard let result = result else {
        return Date()
    }
    return result
}

//func getImageFromServer(imgName: String) -> UIImage {
//    var image = UIImage()
//    AF.request("http://127.0.0.1:8080/img/\(imgName)").response { response in
//                    let data = response.data
//                    image = UIImage(data: data!)!
//        print(image)
//
//
//       }
//    print(image)
//    return image
//}
