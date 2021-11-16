//
//  AlbumInfoViewController.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import UIKit

class AlbumInfoViewController: UIViewController {
    
    var album: Album?
    
    @IBOutlet weak var albumCoverImage: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var tracksNumberLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        albumNameLabel.numberOfLines = 0
        artistNameLabel.numberOfLines = 0
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        confrigureAlbumCell()
    }
    
    
    func confrigureAlbumCell() {
        guard let album = album else { return }
        self.albumNameLabel.text = album.collectionName
        self.artistNameLabel.text = album.artistName
        self.yearLabel.text = album.releaseDate
        self.tracksNumberLabel.text = "\(album.trackCount)"
        
        if let urlString = album.artworkUrl100 {
            NetworkRequest.shared.requestData(urlString: urlString) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumCoverImage.image = image
                case .failure(let error):
                    self?.albumCoverImage.image = nil
                    print("Album logo is not available" + error.localizedDescription)
                }
            }
        } else {
            self.albumCoverImage.image = nil
        }
    }
}
