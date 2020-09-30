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
    
    func fetchApps(completion: @escaping ([Result], Error?) -> ()) {
        
        //create URLString
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
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
}

