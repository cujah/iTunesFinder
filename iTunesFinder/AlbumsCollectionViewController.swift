//
//  AlbumsCollectionViewController.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import UIKit



private let reuseIdentifier = "albumCoverCell"

class AlbumsCollectionViewController: UICollectionViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    
    
    var albums = [Album]()
    var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegate()
        setupNavigationBar()
        setupSearhController()
        
    }

    
    // MARK: - Navigation

    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    
    private func setupNavigationBar() {
        navigationItem.title = "Albums"
        navigationItem.searchController = searchController
        
    }
    
    private func setupSearhController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbumInfoSegue" {
            if self.collectionView.indexPathsForSelectedItems != nil {
                let albumInfoVC = segue.destination as! AlbumInfoViewController
                if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
                    let album = albums[indexPath.row]
                    albumInfoVC.album = album
                }
            }
        }
    }
    
    
    private func fetchAlbums(albumName: String) {
        
        let urlString = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"
        
        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] albumModel, error in
            if error == nil {
                guard let albumModel = albumModel else { return }
                self?.albums = albumModel.results
                print(self?.albums)
                self?.collectionView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
        
    }
    
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlbumCoverCollectionViewCell
        let album = albums[indexPath.row]
        cell.confrigureAlbumCell(album: album)
        return cell
    }

    
    // MARK: UICollectionViewDelegate

    
}

// MARK: UISearchBar Delegate

extension AlbumsCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                let search = searchText.split(separator: " ").joined(separator: "%20")
                self?.fetchAlbums(albumName: search)
            })
        }
    }
}


