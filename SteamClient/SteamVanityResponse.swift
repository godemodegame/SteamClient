import Foundation

struct SteamVanityResponse : Codable {
    let steamid : String?
    let success : Int?

    enum CodingKeys: String, CodingKey {
        case steamid
        case success
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        steamid = try values.decodeIfPresent(String.self, forKey: .steamid)
        success = try values.decodeIfPresent(Int.self, forKey: .success)
    }
}
