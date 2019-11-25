import Foundation

protocol FriendsInteractorProtocol: class {
    func fetchFriends()
}

final class FriendsInteractor: FriendsInteractorProtocol {
    
    weak var presenter: FriendsPresenterProtocol!
    let storageService = StorageService()
    let networkService = NetworkService()
    
    required init(presenter: FriendsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetchFriends() {
        if let user = storageService.loadUser() {
            self.networkService.getFriendsList(user: user.steamId) { friends in
                friends?.forEach {
                    self.networkService.getPlayerSummaries(id: $0.steamid) { user in
                        if let user = user {
                            self.presenter.append(user)
                        }
                    }
                }
            }
        }
    }
}
