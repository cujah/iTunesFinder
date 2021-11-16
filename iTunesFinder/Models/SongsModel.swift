//
//  SongsModel.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import Foundation


struct SongsModel: Codable {
    
    let results: [Song]
    
}


struct Song: Codable {
    
    let trackName: String?
    
    
}
