import Foundation

struct User: Codable {
    let steamId: String
    let name: String?
    let littleAvatar: URL?
    let fullAvatar: URL?
    let state: Int?
}
