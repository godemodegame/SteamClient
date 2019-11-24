import Foundation

protocol ProfileInteractorProtocol: class {
    func fetchUser()
    func fetchOwnedGames()
}

final class ProfileInteractor: ProfileInteractorProtocol {
    
    weak var presenter: ProfilePresenterProtocol!
    let storageService = StorageService()
    let networkService = NetworkService()
    
    required init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetchUser() {
        if let user = self.storageService.loadUser() {
            self.networkService.getPlayerSummaries(id: user) { userResponse in
                if let user = userResponse {
                    self.presenter.show(profile: user)
                }
            }
        } else {
            self.presenter.setLoginButton()
        }
    }
    
    func fetchOwnedGames() {
        if let user = self.storageService.loadUser() {
            self.networkService.getOwnedGame(user: user) { ownedGamesResponse in
                if ownedGamesResponse == nil {
                    self.presenter.gamesFailed()
                }
                self.presenter.set(tableViewModel: ownedGamesResponse?.games)
            }
        }
    }
}
