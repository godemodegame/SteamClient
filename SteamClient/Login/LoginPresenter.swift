import Foundation

protocol LoginPresenterProtocol: class {
    func configureView()
    func closeButtonClicked()
    func failConnection()
    func isFetched(url: URL) -> Bool
    func idFound()
}

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewProtocol!
    var interactor: LoginInteractorProtocol!
    var router: LoginRouterProtocol!
    
    required init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        self.view.loadWebView(request: self.interactor.loginUrl)
        self.view.setButton()
    }
    
    func closeButtonClicked() {
        self.router.closeCurrentViewController()
    }
    
    func idFound() {
        self.router.closeCurrentViewController()
    }
    
    func failConnection() {
        self.router.closeCurrentViewController()
    }
    
    func isFetched(url: URL) -> Bool {
        return self.interactor.findId(in: url.absoluteString)
    }
}
