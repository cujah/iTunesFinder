//
//  NetworkRequest.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import Foundation

class NetworkRequest {
    
    static  let shared = NetworkRequest()                       // синглтон
    
    private init() {}
   
    func requestData(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {  // у резалта 2 состояния - .failure и .success
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, restponse, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
    
}
