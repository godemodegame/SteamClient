import Foundation

protocol RecentlyPlayedRouterProtocol: class {
    
}

final class RecentlyPlayedRouter: RecentlyPlayedRouterProtocol {
    weak var viewController: RecentlyPlayedViewController!
    
    required init(viewController: RecentlyPlayedViewController) {
        self.viewController = viewController
    }
}
