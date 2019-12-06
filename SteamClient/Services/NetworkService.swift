import Alamofire

class NetworkService {
    
    private static let key = "E4CB46E8AD8BC6DD3D87762C8C74B775"
    private let url = "https://api.steampowered.com"
    
    public func getRecentlyPlayedGames(user id: String, completion: @escaping ([Games.Response.Game]?) -> Void) {
        let fullUrl = self.url + "/IPlayerService/GetRecentlyPlayedGames/v0001/?key=\(NetworkService.key)&steamid=\(id)&format=json"
        
        self.request(url: fullUrl, responseType: Games.self) { games in
            completion(games?.response.games)
        }
    }
    
    //http://api.steampowered.com/ISteamUser/GetFriendList/v0001/?key=E4CB46E8AD8BC6DD3D87762C8C74B775&steamid=76561198055671877&relationship=friend
    public func getFriendsList(user id: String, completion: @escaping ([FriendsResponse.FriendsList.Friend]?) -> Void) {
        let fullUrl = self.url + "/ISteamUser/GetFriendList/v0001/?key=\(NetworkService.key)&steamid=\(id)&relationship=friend"
        
        self.request(url: fullUrl, responseType: FriendsResponse.self) { friendsResponse in
            completion(friendsResponse?.friendslist.friends)
        }
    }
    
    // https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=E4CB46E8AD8BC6DD3D87762C8C74B775&steamid=76561198055671877&format=json&include_appinfo=true
    public func getOwnedGame(user id: String, completion: @escaping (Games.Response?) -> Void) {
        let fullUrl = self.url + "/IPlayerService/GetOwnedGames/v0001/?key=\(NetworkService.key)&steamid=\(id)&format=json&include_appinfo=true"
        
        self.request(url: fullUrl, responseType: Games.self) { ownedGames in
            completion(ownedGames?.response)
        }
    }
    
    // https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=E4CB46E8AD8BC6DD3D87762C8C74B775&steamid=76561198055671877&format=json&include_appinfo=true
    public func resolve(vanityUrl: String, completion: @escaping (SteamVanity.Response?) -> Void) {
        let fullUrl = self.url + "/ISteamUser/ResolveVanityURL/v0001/?key=\(NetworkService.key)&vanityurl=\(vanityUrl)"
        
        self.request(url: fullUrl, responseType: SteamVanity.self) { steamVanity in
            completion(steamVanity?.response)
        }
    }
    
    public func getPlayerSummaries(id: String, completion: @escaping (PlayerSummaries.Response.Player?) -> Void) {
        let fullUrl = self.url + "/ISteamUser/GetPlayerSummaries/v0002/?key=\(NetworkService.key)&steamids=\(id)"
        
        self.request(url: fullUrl, responseType: PlayerSummaries.self) { playerSummaries in
            playerSummaries?.response.players.forEach { if $0.steamid == id { completion($0) } }
        }
    }
    
    private func request<T:Codable>(url: String, responseType: T.Type, completion: @escaping (T?) -> Void) {
        Alamofire.request(url).response { dataResponse in
            if let error = dataResponse.error {
                print("Error received requesting data: \(error.localizedDescription)")
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let object = try decoder.decode(T.self, from: data)
                completion(object)
            } catch let jsonError {
                print("Failed to decode JSON: ", jsonError)
                completion(nil)
            }
        }
    }
}
