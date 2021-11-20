//
//  HistoryTableViewCellViewModelType.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation



protocol HistoryTableViewCellViewModelType: AnyObject {
    
    var historyRequest: SearchRequest { get }
    
}
