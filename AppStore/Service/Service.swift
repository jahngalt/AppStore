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
    
    
    func fetchApps(searchItem: String, completion: @escaping ([Result], Error?) -> ()) {
        //create URLString
        let urlString = "https://itunes.apple.com/search?term=\(searchItem)&entity=software"
        //convert URLString to URL
        guard let url = URL(string: urlString) else { return }
        //fetch data from the Internet
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //check if error
            if let error = error {
                print("Failed to fetch apps: ", error)
                completion([], nil)
                return
            }
            guard let data = data else { return }
            
            //If not error, then success
            //Here we using JSONDecoder to decode our data
            do {
                let decoder = JSONDecoder()
                let searchResults = try decoder.decode(SearchResult.self, from: data)
                
                completion(searchResults.results, nil)
                
                
            } catch let jsonErr {
                print("There is some error decoding the data", jsonErr)
                completion([], jsonErr)
            }
        }.resume() //Start the request
    }
    
    
    func fetchTopGrossing(completion: @escaping(AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchGames(completion: @escaping(AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    
    //helper function
    
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            do {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let appGroup = try decoder.decode(AppGroup.self, from: data)
                //success
                //appGroup.feed.results.forEach({print($0.artistName)})
                completion(appGroup, nil)
                
            } catch let jsonErr {
                completion(nil, error)
                print("Failed to decode ", jsonErr)
            }
        }.resume()
        
    }
    
    
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            do {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let objects = try decoder.decode([SocialApp].self, from: data)
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

