import Foundation

protocol UserDefaulting {
    func saveLastUpdatedCheck(setting: Date)
    func retrieveLastUpdatedCheck() -> Int
}

class Defaults: UserDefaulting {
    private let updateCheckKey = "updateCheck"

    func saveLastUpdatedCheck(setting: Date) {
        UserDefaults.standard.set(setting, forKey: updateCheckKey)
    }

    func retrieveLastUpdatedCheck() -> Int {
        return  UserDefaults.standard.integer(forKey: updateCheckKey)
    }
}
