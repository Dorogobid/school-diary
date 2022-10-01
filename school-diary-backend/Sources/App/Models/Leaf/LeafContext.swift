import Foundation

struct LeafContext: Encodable {
    var userType: String
    var name: String
    var className: String
    var photo: String
    var dateOfBirth: String
    var marksText: [MarkFull] = []
}
