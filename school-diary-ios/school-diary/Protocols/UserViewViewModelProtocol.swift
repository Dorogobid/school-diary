import Bond

protocol UserViewViewModelProtocol {
    var marks: MutableObservableArray<Mark> { get }
    
    func getUser() -> UserProtocol
    func isBirthdayNow() -> Bool
    func getMarks()
}
