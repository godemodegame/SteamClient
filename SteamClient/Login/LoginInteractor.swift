import Foundation

protocol LoginInteractorProtocol: class {
    var loginUrl: URLRequest { get }
    func findId(in string: String) -> Bool
}

class LoginInteractor: LoginInteractorProtocol {
    
    weak var presenter: LoginPresenterProtocol!
    
    required init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
    
    var loginUrl: URLRequest {
        let url = URL(string: "https://steamcommunity.com/mobilelogin")!
        return URLRequest(url: url)
    }
    
    func findId(in string: String) -> Bool {
        if string.contains("steamcommunity.com/profiles/") || string.contains("steamcommunity.com/id/") {
            print(string)
            return true
        } else {
            print("---", string)
            return false
        }
        
        if ((string as NSString?)?.range(of: "steamcommunity.com/profiles/"))?.location != NSNotFound {
            let urlComponents = string.components(separatedBy: "/")
            let potentialID: String = urlComponents[4]
            let _ = SteamUser(steamID64: potentialID)
            self.presenter.idFound()
            return true
        } else if ((string as NSString?)?.range(of: "steamcommunity.com/id/"))?.location != NSNotFound {
            let urlComponents = string.components(separatedBy: "/")
            let potentialVanityID: String = urlComponents[4]
            let _ = SteamUser(steamVanityID: potentialVanityID)
            self.presenter.idFound()
            return true
        } else {
            return false
        }
    }
}
