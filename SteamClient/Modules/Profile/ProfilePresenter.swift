import Foundation

protocol ProfilePresenterProtocol: class {
    func configureUserView()
    func configureFriendView(user: User)
    func setLoginButton()
    func loginButtonTapped()
    func logoutButtonTapped()
    func show(user: User)
    func set(tableViewModel: [Games.Response.Game]?)
    func gamesFailed()
    func reload()
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol!
    var interactor: ProfileInteractorProtocol!
    var router: ProfileRouterProtocol!
    var headerView: ProfileHeaderViewProtocol?
    
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
    
    func configureUserView() {
        self.view.setupBackground()
        if let user = self.interactor.loadUser() {
            self.show(user: user)
            self.interactor.fetchUser(id: user.steamId) { user in
                if let user = user {
                    self.show(user: user)
                }
            }
        } else {
            self.setLoginButton()
        }
    }
    
    func configureFriendView(user: User) {
        self.view.setupBackground()
        self.view.setupHeader()
        self.headerView?.name = user.name
        self.headerView?.imageUrl = user.fullAvatar
        self.headerView?.state = user.state ?? 0
        self.view.setupTableView()
        self.interactor.fetchOwnedGames(id: user.steamId)
    }
    
    func show(user: User) {
        self.interactor.fetchOwnedGames(id: user.steamId)
        self.view.setupHeader()
        self.headerView?.name = user.name
        self.headerView?.imageUrl = user.fullAvatar
        self.headerView?.state = user.state ?? 0
        self.view.showLogoutButton()
        self.view.setupTableView()
    }
    
    func setLoginButton() {
        self.view.showLoginButton()
    }
    
    func loginButtonTapped() {
        self.router.showLoginScreen(delegate: self)
    }
    
    func set(tableViewModel: [Games.Response.Game]?) {
        self.headerView?.gamesCount = tableViewModel?.count
        self.view.tableViewModel = tableViewModel
    }
    
    func gamesFailed() {
        self.view.setupFailGames()
    }
    
    func reload() {
        self.view.hideFail()
        self.view.hideHeader()
        self.view.hideTableView()
    }
    
    func logoutButtonTapped() {
        self.view.hideFail()
        self.view.hideHeader()
        self.view.hideTableView()
        self.view.showLoginButton()
        self.interactor.clearUser()
    }
}

extension ProfilePresenter: LoginDelegate {
    func finishedAuthorization(with id: String) {
        self.interactor.fetchUser(id: id) { user in
            if let user = user {
                self.show(user: user)
                self.interactor.save(user: user)
            }
        }
    }
}
