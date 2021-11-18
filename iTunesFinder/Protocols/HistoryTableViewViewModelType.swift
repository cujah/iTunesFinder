//
//  HistoryTableViewViewModelType.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation

protocol HistoryTableViewViewModelType {
    
    func numberOfRowsInSection() -> Int 
    func cellViewModel(forIndexPath indexPath: IndexPath) -> HistoryTableViewCellViewModelType?
    
    func getSearchRequestsHistory()
    func clearHistory()
}
