//
//  ViewModel.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation


class ViewModel: AlbumsCollectionViewModelType {
    var numberOfItemsInSection: Int {
        return albums.count
    }
    
    var albums: [Album] = []
     
    
}
