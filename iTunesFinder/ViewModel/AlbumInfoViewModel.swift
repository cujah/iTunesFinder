//
//  AlbumIfoViewModel.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation


class AlbumInfoViewModel: AlbumInfoViewModelType {
    
    private var album: Album
    
    init(album: Album) {
        self.album = album
    }
    
    var albumCoverUlr: String? {
        return album.artworkUrl100
    }
    
    var albumName: String {
        return album.collectionName
    }
    
    var artistName: String {
        return album.artistName
    }
    
    var releaseDate: String {
        return album.releaseDate
    }
    
    var tracksCount: Int {
        return album.trackCount
    }
    
    var genre: String {
        return album.primaryGenreName
    }
    
    var collectionId: Int {
        return album.collectionId
    }
    
}
