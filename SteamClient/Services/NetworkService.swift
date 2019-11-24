import Alamofire

struct SteamVanity: Codable {
    let response: Response
    
    struct Response: Codable {
        let success: Int
        let steamid: String
    }
}

struct PlayerSummaries: Codable {
    let response: Response
    
    struct Response: Codable {
        let players: [Player]
        
        struct Player: Codable {
            let steamid: String
            let communityvisibilitystate: Int
            let profilestate: Int
            let personaname: String
            let lastlogoff: Int
            let commentpermission: Int
            let profileurl: URL
            let avatar: URL
            let avatarmedium: URL
            let avatarfull: URL
            let personastate: Int
            let primaryclanid: String
            let timecreated: Int
            let personastateflags: Int
            let loccountrycode: String
            let locstatecode: String
            let loccityid: Int
        }
    }
}

struct OwnedGames: Codable {
    let response: Response
    
    struct Response: Codable {
        let game_count: Int
        let games: [Game]
        
        struct Game: Codable {
            let name: String
            let img_icon_url: String
            let img_logo_url: String
            let has_community_visible_stats: Bool
            let appid: Int
            let playtime_forever: Int
            let playtime_windows_forever: Int
            let playtime_mac_forever: Int
            let playtime_linux_forever: Int
        }
    }
}

class NetworkService {
    
    private static let key = "E4CB46E8AD8BC6DD3D87762C8C74B775"
    private let url = "https://api.steampowered.com"
    
    public func getOwnedGame(user id: String, completion: @escaping (OwnedGames.Response?) -> Void) {
        // https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=E4CB46E8AD8BC6DD3D87762C8C74B775&steamid=\(id)&format=json&include_appinfo=true
        let fullUrl = self.url + "/IPlayerService/GetOwnedGames/v0001/?key=\(NetworkService.key)&steamid=\(id)&format=json&include_appinfo=true"
        
        self.request(url: fullUrl, responseType: OwnedGames.self) { ownedGames in
            completion(ownedGames?.response)
        }
    }
    
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
