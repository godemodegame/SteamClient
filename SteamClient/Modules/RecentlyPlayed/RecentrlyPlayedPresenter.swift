import Foundation

protocol RecentlyPlayedPresenterProtocol: class {
    func configureView()
    func set(viewModel: [Games.Response.Game])
}

final class RecentlyPlayedPresenter: RecentlyPlayedPresenterProtocol {
    
    weak var view: RecentlyPlayedViewProtocol!
    var interactor: RecentlyPlayedInteractorProtocol!
    var router: RecentlyPlayedRouterProtocol!
    
    required init(view: RecentlyPlayedViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        self.view.setupTableView()
        self.interactor.fetchGames(for: self.interactor.id)
    }
    
    func set(viewModel: [Games.Response.Game]) {
        self.view.tableViewModel = viewModel
    }
}
