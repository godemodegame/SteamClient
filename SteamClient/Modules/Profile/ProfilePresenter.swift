import Foundation

protocol ProfilePresenterProtocol: class {
    func configureView()
    func setLoginButton()
    func loginButtonTapped()
    func show(profile: PlayerSummaries.Response.Player)
    func set(tableViewModel: [OwnedGames.Response.Game]?)
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
    
    func configureView() {
        self.interactor.fetchUser()
    }
    
    func show(profile: PlayerSummaries.Response.Player) {
        self.interactor.fetchOwnedGames()
        self.view.setupHeader()
        self.headerView?.name = profile.personaname
        self.headerView?.imageUrl = profile.avatarfull
        self.headerView?.state = profile.personastate
        self.view.hideLoginButton()
        self.view.setupTableView()
    }
    
    func setLoginButton() {
        self.view.setupLoginButton()
    }
    
    func loginButtonTapped() {
        self.router.showLoginScreen(delegate: self)
    }
    
    func set(tableViewModel: [OwnedGames.Response.Game]?) {
        self.view.tableViewModel = tableViewModel
    }
    
    func gamesFailed() {
        self.view.setupFailGames()
    }
    
    func reload() {
        self.view.hideFail()
        self.view.hideHeader()
        self.view.hideLoginButton()
        self.view.hideTableView()
        
        self.interactor.fetchUser()
    }
}

extension ProfilePresenter: LoginDelegate {
    func finishedAuthorization() {
        self.interactor.fetchUser()
    }
}
