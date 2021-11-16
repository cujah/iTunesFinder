//
//  AlbumsCollectionViewController.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import UIKit

private let reuseIdentifier = "albumCoverCell"

class AlbumsCollectionViewController: UICollectionViewController {

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
        
    }

    
    // MARK: - Navigation

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

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
