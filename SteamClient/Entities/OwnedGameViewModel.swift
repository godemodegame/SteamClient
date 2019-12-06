import Foundation

protocol OwnedGameViewModel {
    var name: String { get }
    var logoUrlString: String { get }
    var appId: Int { get }
    var playTimeForever: Int { get }
}

extension OwnedGameViewModel {
    var imageUrl: URL? {
        get {
            URL(string: "http://media.steampowered.com/steamcommunity/public/images/apps/\(self.appId)/\(self.logoUrlString).jpg")
        }
    }
    
    var playedHours: String {
        get {
            "\(self.playTimeForever / 60) h"
        }
    }
}
