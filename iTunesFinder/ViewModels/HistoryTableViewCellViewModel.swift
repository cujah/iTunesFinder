//
//  HistoryTableViewCellViewModel.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation


class HistoryTableViewCellViewModel: HistoryTableViewCellViewModelType {
    
    var historyRequest: SearchRequest
    
    private var searchRequest: SearchRequest {
        return historyRequest
    }
    
    init(searchRequest: SearchRequest) {
        self.historyRequest = searchRequest
    }

}
