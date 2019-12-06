import Foundation

protocol RecentlyGameViewModel {
    var name: String { get }
    var logoUrlString: String { get }
    var appId: Int { get }
    var playTimeForever: Int { get }
    var playTimeTwoWeeks: Int? { get }
}

extension RecentlyGameViewModel {
    var imageUrl: URL? {
        get {
            URL(string: "http://media.steampowered.com/steamcommunity/public/images/apps/\(self.appId)/\(self.logoUrlString).jpg")
        }
    }
    
    var playedHoursForever: String {
        get {
            "during time: \(self.playTimeForever / 60) h"
        }
    }
    
    var playedHoursLastTwoWeeks: String? {
        get {
            if let string = self.playTimeTwoWeeks {
                return "last 2 weeks: \(string / 60) h"
            }
            return nil
        }
    }
}
