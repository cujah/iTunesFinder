//
//  CollectionViewCellViewModel.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation
import UIKit


class CollectionViewCellViewModel: AlbumsCollectionCellViewModelType {
    

    private var album: Album
    
    var albumCoverImageUrl: String? {
        return album.artworkUrl100
    }
    
    var albumName: String {
        return album.collectionName
    }
    
    var artistName: String {
        return album.artistName
    }
    
    init(album: Album) {
        self.album = album
    }

    
}
