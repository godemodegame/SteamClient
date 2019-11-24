import Foundation

struct OwnedGames: Codable {
    let response: Response
    
    struct Response: Codable {
        let game_count: Int
        let games: [Game]
        
        struct Game: Codable {
            let name: String
            let img_icon_url: String
            let img_logo_url: String
            let has_community_visible_stats: Bool
            let appid: Int
            let playtime_forever: Int
            let playtime_windows_forever: Int
            let playtime_mac_forever: Int
            let playtime_linux_forever: Int
        }
    }
}
