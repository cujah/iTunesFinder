//
//  AlbumsCollectionViewModelType.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation


protocol AlbumsCollectionViewViewModelType {
    func numberOfItemsInSection() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> AlbumsCollectionCellViewModelType?
    
    func viewModelForSelectedItem() -> AlbumInfoViewModelType?
    func selectItem(forIndexPath indexPath: IndexPath)
    
    // временно:
    var albums: [Album] { get set }
}




/// тест
