import UIKit

protocol ProfileRouterProtocol: class {
    func showLoginScreen(delegate: LoginDelegate)
}

final class ProfileRouter: ProfileRouterProtocol {
    weak var viewController: ProfileViewController!
    
    required init(viewController: ProfileViewController) {
        self.viewController = viewController
    }
    
    func showLoginScreen(delegate: LoginDelegate) {
        let viewController = LoginViewController(delegate: delegate)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.viewController.present(navigationController, animated: true, completion: nil)
    }
}
