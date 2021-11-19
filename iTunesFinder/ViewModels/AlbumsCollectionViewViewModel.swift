//
//  ViewModel.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation
import CoreData
import UIKit


class AlbumsCollectionViewViewModel: AlbumsCollectionViewViewModelType {
    
    private var albums: [Album] = []
    private var selectedIndexPath: IndexPath?
    private var searchRequest: SearchRequest?
    
    init() {}
    
    init(searchRequest: SearchRequest) {
        self.searchRequest = searchRequest
    }
    
    
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
    
    func fetchAlbums(albumName: String) {
        let urlString = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"
        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] albumModel, error in
            if error == nil {
                guard let albumModel = albumModel else { return }
                if albumModel.results != [] {
                    let sortedAlbums = albumModel.results.sorted { firstItem, secondItem in
                        return firstItem.collectionName.compare(secondItem.collectionName) == ComparisonResult.orderedAscending
                    }
                    self?.albums = sortedAlbums
//                    self?.collectionView.reloadData()
                } else {
                    //alertOk(title: "Not found =(", message: "Album not found, try another words.")
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func saveSearchRequest(withRequest request: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SearchRequest", in: context) else { return }
        let searchRequestObject = SearchRequest(entity: entity, insertInto: context)
        searchRequestObject.searchRequest = request
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    
}
