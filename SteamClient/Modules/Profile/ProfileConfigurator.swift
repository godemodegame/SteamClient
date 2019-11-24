import UIKit

protocol ProfileConfiguratorProtocol: class {
    func configure(with viewController: ProfileViewController)
}

final class ProfileConfigurator: ProfileConfiguratorProtocol {
    func configure(with viewController: ProfileViewController) {
        let presenter = ProfilePresenter(view: viewController)
        let interactor = ProfileInteractor(presenter: presenter)
        let router = ProfileRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.headerView = viewController.headerView
        presenter.router = router
    }
}
