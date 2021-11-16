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
    @IBOutlet weak var genreLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumNameLabel.numberOfLines = 0
        artistNameLabel.numberOfLines = 0
        confrigureAlbumInfo()
    }
    
    private func confrigureAlbumInfo() {
        guard let album = album else { return }
        albumNameLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        yearLabel.text = setDateFormat(date: album.releaseDate)
        tracksNumberLabel.text = "\(album.trackCount)"
        genreLable.text = album.primaryGenreName
        
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
    
    private func setDateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let backendDate = dateFormatter.date(from: date) else { return "" }
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd.MM.yyyy"
        let date = formatDate.string(from: backendDate)
        return date
    }
}
