import UIKit

protocol AddMarkViewViewModelProtocol {
    var marks : [Int] { get }
    var subjects: Subjects { get }
    var students: Students { get }
    var teacherId : String { get }
    
    func getMark(row: Int) -> String
    func addMark(vc: UIViewController, mark: MarkRequest, completionBlock: @escaping () -> ())
}
