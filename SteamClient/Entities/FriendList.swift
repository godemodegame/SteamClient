import Foundation

struct FriendsResponse: Codable {
    let friendslist: FriendsList
    
    struct FriendsList: Codable {
        let friends: [Friend]
        
        struct Friend: Codable {
            let steamid: String
            let relationship: String
            let friend_since: Int
        }
    }
}
