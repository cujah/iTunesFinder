//
//  AlbumsCollectionViewController.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import UIKit
import CoreData


private let reuseIdentifier = "albumCoverCell"

class AlbumsCollectionViewController: UICollectionViewController {
    
    var viewModel: AlbumsCollectionViewViewModelType?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AlbumsCollectionViewViewModel()

        setupDelegate()
        setupNavigationBar()
        setupSearhController()
        setupCollectionView()
        
    }

    
    // MARK: - Navigation

    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchController.searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView.showsVerticalScrollIndicator = false
    }
    
    
    private func setupNavigationBar() {
        navigationItem.title = "Albums"
        navigationItem.searchController = searchController
    }
    
    
    private func setupSearhController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectItem(forIndexPath: indexPath)
        performSegue(withIdentifier: "showAlbumInfoSegue", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = viewModel else { return }
        if identifier == "showAlbumInfoSegue" {
            if let dvc = segue.destination as? AlbumInfoViewController {
                dvc.viewModel = viewModel.viewModelForSelectedItem()
            }
        }
    }
    
    
// MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection() ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AlbumCoverCollectionViewCell
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        collectionViewCell.viewModel = cellViewModel
        return collectionViewCell
    }
}


// MARK: UISearchBar Delegate

extension AlbumsCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchTextRequest = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if searchTextRequest != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                let searchRequest = searchText
                let search = searchTextRequest!.split(separator: " ").joined(separator: "%20")
                guard let viewModel = self?.viewModel else { return }
                viewModel.fetchAlbums(albumName: search)
                viewModel.saveSearchRequest(withRequest: searchRequest)
                self?.collectionView.reloadData()
            })
        }
    }
}


