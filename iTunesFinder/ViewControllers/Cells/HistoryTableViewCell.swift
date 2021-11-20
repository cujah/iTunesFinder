//
//  HistoryTableViewCell.swift
//  iTunesFinder
//
//  Created by Илья on 17.11.2021.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var historyRequestLabel: UILabel!
    
    weak var viewModel: HistoryTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            historyRequestLabel.text = viewModel.historyRequest.searchRequest
        }
    }
}
