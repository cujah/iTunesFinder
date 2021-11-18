//
//  HistoryTableViewController.swift
//  iTunesFinder
//
//  Created by Илья on 17.11.2021.
//

import UIKit
import CoreData

private let reuseIdentifier = "historyCell"

class HistoryTableViewController: UITableViewController {
    
    var viewModel: HistoryTableViewViewModelType?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel?.getSearchRequestsHistory()
        tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HistoryTableViewModel()
        setupTableView()
        
    }

    private func setupTableView() {
        self.title = "Search History"
        tableView.showsVerticalScrollIndicator = false
    }
    
//    private func getSearchRequestsHistory() {
//        let context = getContext()
//
//        let fetchReqest: NSFetchRequest<SearchRequest> = SearchRequest.fetchRequest()
//        do {
//            history = try context.fetch(fetchReqest).reversed()
//            self.tableView.reloadData()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
    
    @IBAction func clearHistoryButtonPressed(_ sender: Any) {
        alertOkCancel(title: "Clear the history?", message: "Press OK to clear the search history.") {
            self.viewModel?.clearHistory()
            self.tableView.reloadData()
        }
    }
    
    
    
//    private func clearHistory() {
//        let context = getContext()
//        let fetchReqest: NSFetchRequest<SearchRequest> = SearchRequest.fetchRequest()
//        if let requests = try? context.fetch(fetchReqest) {
//            for request in requests {
//                context.delete(request)
//            }
//        }
//        do {
//            try context.save()
//            self.tableView.reloadData()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
    
//    private func getContext() -> NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext
//    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? HistoryTableViewCell
        guard let historyCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        historyCell.viewModel = cellViewModel
        return historyCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "historyRequestSegue" {
//            guard let indexPath = tableView.indexPathForSelectedRow,
//                  let dvc = segue.destination as? AlbumsCollectionViewController,
//                  let viewModel = viewModel,
//                  let searchRequest = viewModel.history[indexPath.row].searchRequest else { return }
//            dvc.historyRequest = searchRequest
            
        }
    }
    
    
}



