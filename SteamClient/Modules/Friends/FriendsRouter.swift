import Foundation

protocol FriendsRouterProtocol: class {
    
}

final class FriendsRouter: FriendsRouterProtocol {
    weak var viewController: FriendsViewController!
    
    required init(viewController: FriendsViewController) {
        self.viewController = viewController
    }
}
