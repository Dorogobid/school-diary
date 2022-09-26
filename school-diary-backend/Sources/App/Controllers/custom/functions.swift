import Foundation

func hashStr(_ str: String) -> String {
    str.data(using: .utf8)!.md5
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
