//
//  AlbumInfoViewController.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import UIKit

private let reuseIdentifier = "trackId"

class AlbumInfoViewController: UIViewController {
    
    var viewModel: AlbumInfoViewModelType?
    private let defaultImage = UIImage(named: "defaultCover")
    
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
        guard let viewModel = viewModel else { return }
        albumNameLabel.text = viewModel.albumName
        artistNameLabel.text = viewModel.artistName
        yearLabel.text = viewModel.releaseDate
        tracksNumberLabel.text = "\(viewModel.tracksCount)"
        genreLable.text = viewModel.genre
        
        if let urlString = viewModel.albumCoverUlr {
            NetworkRequest.shared.requestData(urlString: urlString) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumCoverImage.image = image
                case .failure(let error):
                    self?.albumCoverImage.image = self?.defaultImage
                    print("Album logo is not available" + error.localizedDescription)
                }
            }
        } else {
            self.albumCoverImage.image = self.defaultImage
        }
        viewModel.fetchSong(idAlbum: viewModel.collectionId, completion: { status in
            if status {
                self.tableView.reloadData()
            } else {
                self.alertOk(title: "Error", message: "Failed to load data")
            }
        })
        
    }
    
}

// MARK: - Table view delegate & data source

extension AlbumInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SongTableViewCell
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
