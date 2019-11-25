import Foundation

protocol FriendsRouterProtocol: class {
    func openDetail(friend: Friend)
}

final class FriendsRouter: FriendsRouterProtocol {
    weak var viewController: FriendsViewController!
    
    required init(viewController: FriendsViewController) {
        self.viewController = viewController
    }
    
    func openDetail(friend: Friend) {
        self.viewController.navigationController?.pushViewController(ProfileViewController(friend: friend), animated: true)
    }
}
