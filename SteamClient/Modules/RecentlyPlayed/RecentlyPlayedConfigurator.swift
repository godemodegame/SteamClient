import Foundation

protocol RecentlyPlayedConfiguratorProtocol: class {
    func configure(with viewController: RecentlyPlayedViewController)
}

final class RecentlyPlayedConfigurator: RecentlyPlayedConfiguratorProtocol {
    func configure(with viewController: RecentlyPlayedViewController) {
        let presenter = RecentlyPlayedPresenter(view: viewController)
        let interactor = RecentlyPlayedInteractor(presenter: presenter)
        let router = RecentlyPlayedRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
