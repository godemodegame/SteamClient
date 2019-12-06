import Foundation

protocol RecentlyPlayedInteractorProtocol: class {
    var id: String { get }
    func fetchGames(for id: String)
}

final class RecentlyPlayedInteractor: RecentlyPlayedInteractorProtocol {
    
    weak var presenter: RecentlyPlayedPresenterProtocol!
    let networkService = NetworkService()
    
    required init(presenter: RecentlyPlayedPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - не забудь изменить
    
    var id: String {
        return "76561197960434622"
    }
    
    func fetchGames(for id: String) {
        self.networkService.getRecentlyPlayedGames(user: id) { games in
            if let games = games {
                self.presenter.set(viewModel: games)
            }
        }
    }
}
