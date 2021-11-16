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
    
    
    let imageNameArray = ["Baile & Vibes (by VHOOR)",
                          "Baile & Sauce (by VHOOR)",
                          "Baile & Beats (by VHOOR)",
                          "Ritmo (by VHOOR)",
                          "Brazillian Boogie - EP (by VHOOR)",
                          "Baile & Drip (by VHOOR)",
                          "Acima - Single (by Sango & VHOOR)",
                          "Quero Ver (feat. VHOOR) - Single (by Tui)",
                          "Dança pra Mim (feat. Vhoor) [Remix] - Single (by XISNATHAN)",
                          "Dança pra Mim (feat. Vhoor) - Single (by XISNATHAN)",
                          "Baile (by FBC & VHOOR)",
                          "Baile & Trill - EP (by VHOOR, Enzo Di Carlo & Luiz Alves)",
                          "sedenta (feat. VHOOR) - Single (by Mayi)",
                          "Pros Nossos (feat. fleezus & VHOOR) - Single (by Well)",
                          "Delírios - Single (by FBC, VHOOR & Djair Voz Cristalina)",
                          "Muita Fé (feat. Vhoor) - Single (by Well)",
                          "MPBEATS - EP (by VHOOR)",
                          "Outro Rolê (by FBC & VHOOR)",
                          "Minha Vida - Single (by Mac Júlia & VHOOR)",
                          "Capoeira - Single (by VHOOR)"]
    
    
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
                    albumInfoVC.albumName = imageNameArray[indexPath.row]
                }
            }
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlbumCoverCollectionViewCell
        cell.albumCoverImageView.image = UIImage(named: imageNameArray[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewDelegate

    
}

// MARK: UISearchBar Delegate

extension AlbumsCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
    }
}


