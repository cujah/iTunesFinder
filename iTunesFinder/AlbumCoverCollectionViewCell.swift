//
//  AlbumCoverCollectionViewCell.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import UIKit

class AlbumCoverCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var albumCoverImageView: UIImageView!
    
    func confrigureAlbumCell(album: Album) {
        if let urlString = album.artworkUrl100 {
            
            NetworkRequest.shared.requestData(urlString: urlString) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumCoverImageView.image = image
                case .failure(let error):
                    self?.albumCoverImageView.image = nil
                    print("Album logo is not available" + error.localizedDescription)
                }
            }
        } else {
            self.albumCoverImageView.image = nil
        }
    }
    
}
