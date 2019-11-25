import Foundation

protocol FriendsPresenterProtocol: class {
    func configureView()
    func append(_ user: PlayerSummaries.Response.Player)
    func tappedRow(with friend: Friend)
}

final class FriendsPresenter: FriendsPresenterProtocol {
    weak var view: FriendsViewProtocol!
    var interactor: FriendsInteractorProtocol!
    var router: FriendsRouterProtocol!
    
    required init(view: FriendsViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        self.view.setupCell()
        self.interactor.fetchFriends()
    }
    
    func append(_ user: PlayerSummaries.Response.Player) {
        self.view.viewModel.append(Friend(name: user.personaname,
                                          littleAvatar: user.avatarmedium,
                                          fullAvatar: user.avatarfull,
                                          state: user.personastate))
    }
    
    func tappedRow(with friend: Friend) {
        self.router.openDetail(friend: friend)
    }
}
