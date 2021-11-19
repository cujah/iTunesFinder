//
//  AlbumCoverCollectionViewCell.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import UIKit

class AlbumCoverCollectionViewCell: UICollectionViewCell {
    
    private let defaultImage = UIImage(named: "defaultCover")
    
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    
    weak var viewModel: AlbumsCollectionCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            albumLabel.text = viewModel.albumName
            artistLabel.text = viewModel.artistName
            
            if let urlImage = viewModel.albumCoverImageUrl {
                NetworkRequest.shared.requestData(urlString: urlImage) { [weak self] result in
                    switch result {
                    case .success(let data):
                        let image = UIImage(data: data)
                        self?.albumCoverImageView.image = image
                    case .failure(let error):
                        self?.albumCoverImageView.image = self?.defaultImage
                        print("Album logo is not available" + error.localizedDescription)
                    }
                }
            } else {
                self.albumCoverImageView.image = defaultImage
            }
        }
    }
}
