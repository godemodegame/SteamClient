import Foundation

protocol FriendsRouterProtocol: class {
    func openDetail(friend: User)
}

final class FriendsRouter: FriendsRouterProtocol {
    weak var viewController: FriendsViewController!
    
    required init(viewController: FriendsViewController) {
        self.viewController = viewController
    }
    
    func openDetail(friend: User) {
        self.viewController.navigationController?.pushViewController(ProfileViewController(friend: friend), animated: true)
    }
}
