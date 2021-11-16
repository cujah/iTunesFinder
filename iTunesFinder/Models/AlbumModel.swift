//
//  AlbumModel.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import Foundation


struct AlbumModel: Codable {
    let results: [Album]
 
    
    
    
}

struct Album: Codable {
    let artistName: String
    let collectionName: String
    let artworkUrl100: String?
    let trackCount: Int
    let releaseDate: String
}
