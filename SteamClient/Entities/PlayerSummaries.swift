import Foundation

struct PlayerSummaries: Codable {
    let response: Response
    
    struct Response: Codable {
        let players: [Player]
        
        struct Player: Codable {
            let steamid: String
            let communityvisibilitystate: Int
            let profilestate: Int
            let personaname: String
            let lastlogoff: Int
            let commentpermission: Int?
            let profileurl: URL
            let avatar: URL
            let avatarmedium: URL
            let avatarfull: URL
            let personastate: Int
            let primaryclanid: String?
            let timecreated: Int?
            let personastateflags: Int?
            let loccountrycode: String?
            let locstatecode: String?
            let loccityid: Int?
        }
    }
}
