//
//  HistoryTableViewModel.swift
//  iTunesFinder
//
//  Created by Илья on 18.11.2021.
//

import Foundation
import CoreData
import UIKit

class HistoryTableViewModel: HistoryTableViewViewModelType {

    private var history = [SearchRequest]()
    private var selectedIndexPath: IndexPath?
    
    func getSearchRequestsHistory() {
        let context = getContext()
        
        let fetchReqest: NSFetchRequest<SearchRequest> = SearchRequest.fetchRequest()
        do {
            history = try context.fetch(fetchReqest).reversed()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func numberOfRowsInSection() -> Int {
        return history.count
    }
    
    func historyCellViewModel(forIndexPath indexPath: IndexPath) -> HistoryTableViewCellViewModelType? {
        let searchRequest = history[indexPath.row]
        return HistoryTableViewCellViewModel(searchRequest: searchRequest)
    }
    
    
    func clearHistory() {
        let context = getContext()
        let fetchReqest: NSFetchRequest<SearchRequest> = SearchRequest.fetchRequest()
        if let requests = try? context.fetch(fetchReqest) {
            for request in requests {
                context.delete(request)
            }
        }
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func viewModelForSelectedRow() -> AlbumsCollectionViewViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return AlbumsCollectionViewViewModel(searchRequest: history[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
}
