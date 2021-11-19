//
//  TrackTableViewCell.swift
//  iTunesFinder
//
//  Created by Илья on 16.11.2021.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var trackNumberLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!

    weak var viewModel: SongTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            trackNameLabel.text = viewModel.trackName
            if viewModel.trackNumber != nil {
                trackNumberLabel.text = "\(viewModel.trackNumber!)"
            } else {
                trackNumberLabel.text = ""
            }
        }
    }
}
