import Foundation

protocol LoginRouterProtocol: class {
    func closeCurrentViewController()
}

class LoginRouter: LoginRouterProtocol {
    weak var viewController: LoginViewController!
    
    required init(viewController: LoginViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        self.viewController.dismiss(animated: true, completion: nil)
    }
}
