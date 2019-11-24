import Foundation

struct Friend: Codable {
    let name: String
    let littleAvatar: URL
    let fullAvatar: URL
    let state: Int
}
