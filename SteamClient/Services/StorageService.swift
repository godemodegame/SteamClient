import Foundation

class StorageService {
    private let userDefaults = UserDefaults.standard
    
    public func save(user: User) {
        userDefaults.set(try? PropertyListEncoder().encode(user), forKey:"user")
        //self.userDefaults.setValue(user.toDictionary(), forKey: "user")
    }
    
    public func loadUser() -> User? {
        if let data = userDefaults.value(forKey:"user") as? Data {
            return try? PropertyListDecoder().decode(User.self, from: data)
        }
//        if let userDictionary = self.userDefaults.dictionary(forKey: "user") {
//            return User(from: userDictionary)
//        }
        return nil
    }
}
