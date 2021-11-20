//
//  SongTableViewCellViewModelType.swift
//  iTunesFinder
//
//  Created by Илья on 19.11.2021.
//

import Foundation


protocol SongTableViewCellViewModelType: AnyObject {
    
    var trackNumber: Int? { get }
    var trackName: String? { get }
}
