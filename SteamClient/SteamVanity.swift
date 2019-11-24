import Foundation

struct SteamVanity : Codable {
    let response : SteamVanityResponse?
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decodeIfPresent(SteamVanityResponse.self, forKey: .response)
    }
}
