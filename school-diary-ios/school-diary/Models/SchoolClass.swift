import Foundation

// MARK: - SchoolClassWOName
struct SchoolClassWOName: Codable {
    let id :String
//    let className: String
}

typealias SchoolClassesWOName = [SchoolClassWOName]


// MARK: - SchoolClassWOName
struct SchoolClass: Codable {
    let id :String
    let className: String
}

typealias SchoolClasses = [SchoolClass]
