//
//  Service.swift
//  AppStore
//
//  Created by Oleg Kudimov on 9/29/20.
//

import Foundation


class Service {
    
    //singleton
    static let shared = Service()
    
    private init() {}
    
    
    func fetchApps(searchItem: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        //create URLString
        let urlString = "https://itunes.apple.com/search?term=\(searchItem)&entity=software"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    
    func fetchTopGrossing(completion: @escaping(AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)

    }
    
    func fetchGames(completion: @escaping(AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)

    }
    
    
    //helper function
    
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)

    }
    
    
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    
    }
    
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            do {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let objects = try decoder.decode(T.self, from: data)
                //success
                //appGroup.feed.results.forEach({print($0.artistName)})
                completion(objects, nil)
                
            } catch let jsonErr {
                completion(nil, error)
                print("Failed to decode ", jsonErr)
            }
        }.resume()
    }
}
