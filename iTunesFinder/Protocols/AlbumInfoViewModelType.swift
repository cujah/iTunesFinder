//
//  AlbumInfoViewModelTipe.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation


protocol AlbumInfoViewModelType {
    
    var albumCoverUlr: String? { get }
    var albumName: String { get }
    var artistName: String { get }
    var releaseDate: String { get }
    var tracksCount: Int { get }
    var genre: String { get }
    var collectionId: Int { get }
}
