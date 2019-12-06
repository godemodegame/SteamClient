import Foundation

struct Games: Codable {
    let response: Response
    
    struct Response: Codable {
        let gamesCount: Int?
        let games: [Game]
        
        enum CodingKeys: String, CodingKey {
            case gamesCount = "game_count"
            case games
        }
        
        struct Game: Codable, RecentlyGameViewModel, OwnedGameViewModel {
            let name: String
            let iconUrlString: String
            let logoUrlString: String
            let isCommunityVisibleStats: Bool?
            let appId: Int
            let playTimeForever: Int
            let playTimeTwoWeeks: Int?
            let playTimeWindowsForever: Int
            let playTimeMacForever: Int
            let playTimeLinuxForever: Int
            
            enum CodingKeys: String, CodingKey {
                case name
                case iconUrlString = "img_icon_url"
                case logoUrlString = "img_logo_url"
                case isCommunityVisibleStats = "has_community_visible_stats"
                case appId = "appid"
                case playTimeForever = "playtime_forever"
                case playTimeTwoWeeks = "playtime_2weeks"
                case playTimeWindowsForever = "playtime_windows_forever"
                case playTimeMacForever = "playtime_mac_forever"
                case playTimeLinuxForever = "playtime_linux_forever"
            }
        }
    }
}
