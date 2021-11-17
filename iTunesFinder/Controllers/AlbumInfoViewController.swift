//
//  AlbumInfoViewController.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import UIKit

private let reuseIdentifier = "trackId"

class AlbumInfoViewController: UIViewController {
    
    var album: Album?
    var songs = [Song]()
    
    @IBOutlet weak var albumCoverImage: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var tracksNumberLabel: UILabel!
    @IBOutlet weak var genreLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confrigureAlbumInfo()
        fetchSong(album: album)
        setupDelegate()
        setupTableView()
    }
    
    private func setupDelegate() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupTableView(){
        tableView.showsVerticalScrollIndicator = false
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
    
    private func fetchSong(album: Album?) {
        guard let album = album else { return }
        
        let idAlbum = album.collectionId
        let urlString = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song"
        
        NetworkDataFetch.shared.fetchSongs(urlString: urlString) { [weak self] songModel, error in
            if error == nil {
                guard let songModel = songModel else { return }
                self?.songs = songModel.results
                if self?.songs.first?.trackNumber == nil {
                    self?.songs.removeFirst()
                }
                self?.tableView.reloadData()
            } else {
                print(error!.localizedDescription)
                self?.alertOk(title: "Error", message: "Failed to load data")
            }
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

// MARK: - Table view delegate & data source

extension AlbumInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TrackTableViewCell
        let song = songs[indexPath.row]
        cell.trackNumberLabel.text = "\(song.trackNumber!)"
        cell.trackNameLabel.text = song.trackName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
