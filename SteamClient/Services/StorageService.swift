import Foundation

class StorageService {
    private let userDefaults = UserDefaults.standard
    
    public func save(userId: String) {
        self.userDefaults.set(userId, forKey: "UserId")
    }
    
    public func loadUser() -> String? {
        self.userDefaults.string(forKey: "UserId")
    }
}
