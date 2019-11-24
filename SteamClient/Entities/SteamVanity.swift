import Foundation

struct SteamVanity: Codable {
    let response: Response
    
    struct Response: Codable {
        let success: Int
        let steamid: String
    }
}
