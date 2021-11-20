//
//  HistoryTableViewViewModelType.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation

protocol HistoryTableViewViewModelType {
    
    func numberOfRowsInSection() -> Int 
    func historyCellViewModel(forIndexPath indexPath: IndexPath) -> HistoryTableViewCellViewModelType?
    
    func viewModelForSelectedRow() -> AlbumsCollectionViewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    
    func getSearchRequestsHistory()
    func clearHistory()
}
