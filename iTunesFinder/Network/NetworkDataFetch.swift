//
//  NetworkDataFetch.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import Foundation


class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchAlbum (urlString: String, response: @escaping (AlbumModel?, Error?) -> Void) {
        
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            
            switch result {
            case .success(let data):
                do {
                    let albums = try JSONDecoder().decode(AlbumModel.self, from: data)
                    response(albums, nil)
                } catch let jsonError {
                    print("Failure to decode JSON", jsonError)
                }
                
            case .failure(let error):
                print("Error recieved reuesting data: \(error.localizedDescription)")
                response(nil, error)
            }
            
        }
        
    }
    
    
    
}
