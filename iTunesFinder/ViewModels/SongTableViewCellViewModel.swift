//
//  SongTableViewCellViewModel.swift
//  iTunesFinder
//
//  Created by Илья on 19.11.2021.
//

import Foundation


class SongTableViewCellViewModel: SongTableViewCellViewModelType {
    
    private var song: Song
    
    var trackNumber: Int? {
        return song.trackNumber
    }
    
    var trackName: String? {
        return song.trackName
    }
    
    init(song: Song) {
        self.song = song
    }
    
}
