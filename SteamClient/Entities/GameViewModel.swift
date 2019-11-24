import Foundation

struct GameViewModel {
    let imageUrl: URL?
    let name: String
    let playedHours: String
    
    init(appId: Int, hash: String, name: String, played: Int) {
        self.imageUrl = URL(string: "http://media.steampowered.com/steamcommunity/public/images/apps/\(appId)/\(hash).jpg")
        self.name = name
        self.playedHours = "\(played / 60) h"
    }
}
