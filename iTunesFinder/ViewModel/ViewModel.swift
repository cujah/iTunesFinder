//
//  ViewModel.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation


class ViewModel: AlbumsCollectionViewViewModelType {
    
    var albums: [Album] = []
    private var selectedIndexPath: IndexPath?
    
    func numberOfItemsInSection() -> Int {
        return albums.count
    }
     
    func cellViewModel(forIndexPath indexPath: IndexPath) -> AlbumsCollectionCellViewModelType? {
        let album = albums[indexPath.row]
        return CollectionViewCellViewModel(album: album)
    }
    
    
    func viewModelForSelectedItem() -> AlbumInfoViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return AlbumInfoViewModel(album: albums[selectedIndexPath.row])
    }
    
    func selectItem(forIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
}
