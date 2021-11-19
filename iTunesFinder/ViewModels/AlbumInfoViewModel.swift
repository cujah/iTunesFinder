//
//  AlbumIfoViewModel.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation


class AlbumInfoViewModel: AlbumInfoViewModelType {

    private var album: Album
    private var songs: [Song] = []
    
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
    
    func numberOfRowsInSection() -> Int {
        return songs.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SongTableViewCellViewModelType? {
        return SongTableViewCellViewModel(song: songs[indexPath.row])
    }
    
    
    func fetchSong(idAlbum: Int, completion: @escaping (Bool) -> ()) {
        let urlString = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song"
        NetworkDataFetch.shared.fetchSongs(urlString: urlString) { [weak self] songModel, error in
            if error == nil {
                guard let songModel = songModel else { return }
                self?.songs = songModel.results
                if self?.songs.first?.trackNumber == nil {
                    self?.songs.removeFirst()
                }
                completion(true) 
            } else {
                print(error!.localizedDescription)
                completion(false)
            }
        }
    }
    

    
    
}
