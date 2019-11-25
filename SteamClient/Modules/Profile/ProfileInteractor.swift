import Foundation

protocol ProfileInteractorProtocol: class {
    func fetchUser(id: String, completion: @escaping (User?) -> Void)
    func fetchOwnedGames(id: String)
    func save(user: User)
    func loadUser() -> User?
}

final class ProfileInteractor: ProfileInteractorProtocol {
    
    weak var presenter: ProfilePresenterProtocol!
    let storageService = StorageService()
    let networkService = NetworkService()
    
    required init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
    }
    
    func save(user: User) {
        self.storageService.save(user: user)
    }
    
    func loadUser() -> User? {
        self.storageService.loadUser()
    }
    
    func fetchUser(id: String, completion: @escaping (User?) -> Void) {
        self.networkService.getPlayerSummaries(id: id) { userResponse in
            if let user = userResponse {
                completion(User(steamId: user.steamid,
                                name: user.personaname,
                                littleAvatar: user.avatar,
                                fullAvatar: user.avatarfull,
                                state: user.personastate))
            }
        }
    }
    
    func fetchOwnedGames(id: String) {
        self.networkService.getOwnedGame(user: id) { ownedGamesResponse in
            if ownedGamesResponse == nil {
                self.presenter.gamesFailed()
            }
            self.presenter.set(tableViewModel: ownedGamesResponse?.games)
        }
    }
}
