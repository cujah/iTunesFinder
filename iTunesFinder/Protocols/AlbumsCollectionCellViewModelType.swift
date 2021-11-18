//
//  AlbumsCollectionCellViewModelType.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation
import UIKit


protocol AlbumsCollectionCellViewModelType: AnyObject {
    
    var albumCoverImageUrl: String? { get }
    var albumName: String { get }
    var artistName: String { get }
    
}
