//
//  AlbumsCollectionViewModelType.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation


protocol AlbumsCollectionViewModelType {
    var numberOfItemsInSection: Int { get }
    var albums: [Album] { get set }
}
