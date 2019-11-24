import Foundation

protocol LoginInteractorProtocol: class {
    var loginUrl: URLRequest { get }
    func findId(in string: String) -> Bool
}

final class LoginInteractor: LoginInteractorProtocol {
    
    weak var presenter: LoginPresenterProtocol!
    let storageService = StorageService()
    let networkService = NetworkService()
    
    required init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
    
    var loginUrl: URLRequest {
        let url = URL(string: "https://steamcommunity.com/mobilelogin")!
        return URLRequest(url: url)
    }
    
    func findId(in string: String) -> Bool {
        if string.contains("steamcommunity.com/profiles/") || string.contains("steamcommunity.com/id/") {
            let urlComponents = string.components(separatedBy: "/")
            let vanityId = urlComponents[4]
            self.networkService.resolve(vanityUrl: vanityId) { [weak self] (response) in
                guard let response = response else { return }
                self?.storageService.save(userId: response.steamid)
                self?.presenter.idFound()
            }
            return true
        }
        return false
    }
}
