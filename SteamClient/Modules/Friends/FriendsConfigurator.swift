import UIKit

protocol FriendsConfiguratorProtocol: class {
    func configure(with viewController: FriendsViewController)
}

final class FriendsConfigurator: FriendsConfiguratorProtocol {
    func configure(with viewController: FriendsViewController) {
        let presenter = FriendsPresenter(view: viewController)
        let interactor = FriendsInteractor(presenter: presenter)
        let router = FriendsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
