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
    var historyRequest: String? {
        didSet {
            if let request = historyRequest {
                self.fetchAlbums(albumName: request)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()

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
    
    private func saveSearchRequest(withRequest request: String) {
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
    
    private func fetchAlbums(albumName: String) {
        let urlString = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"
        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] albumModel, error in
            if error == nil {
                guard let albumModel = albumModel else { return }
                if albumModel.results != [] {
                    let sortedAlbums = albumModel.results.sorted { firstItem, secondItem in
                        return firstItem.collectionName.compare(secondItem.collectionName) == ComparisonResult.orderedAscending
                    }
                    self?.viewModel?.albums = sortedAlbums
                    self?.collectionView.reloadData()
                } else {
                    self?.alertOk(title: "Not found =(", message: "Album not found, try another words.")
                }
            } else {
                print(error!.localizedDescription)
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
                let search = searchTextRequest!.split(separator: " ").joined(separator: "%20")
                self?.fetchAlbums(albumName: search)
                let requestForSaving = search.replacingOccurrences(of: "%20", with: " ")
                self?.saveSearchRequest(withRequest: requestForSaving)
            })
        }
    }
}


