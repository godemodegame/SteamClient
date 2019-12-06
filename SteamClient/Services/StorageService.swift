import Foundation

class StorageService {
    private let userDefaults = UserDefaults.standard
    
    public func save(user: User) {
        self.userDefaults.set(try? PropertyListEncoder().encode(user), forKey:"user")
    }
    
    public func loadUser() -> User? {
        if let data = self.userDefaults.value(forKey:"user") as? Data {
            return try? PropertyListDecoder().decode(User.self, from: data)
        }
        return nil
    }
    
    public func deleteUser() {
        self.userDefaults.set(nil, forKey: "user")
    }
}
