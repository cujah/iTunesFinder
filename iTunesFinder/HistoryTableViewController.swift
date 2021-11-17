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
    
    private var history = [SearchRequest]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getSearchRequestsHistory()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
    }

    private func setupTableView() {
        self.title = "Search History"
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func getSearchRequestsHistory() {
        let context = getContext()
        
        let fetchReqest: NSFetchRequest<SearchRequest> = SearchRequest.fetchRequest()
        do {
            history = try context.fetch(fetchReqest).reversed()
            self.tableView.reloadData()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func clearHistoryButtonPressed(_ sender: Any) {
        alertOkCancel(title: "Clear the history?", message: "Press OK to clear the search history.") {
            self.clearHistory()
        }
    }
    
    
    private func clearHistory() {
        let context = getContext()
        let fetchReqest: NSFetchRequest<SearchRequest> = SearchRequest.fetchRequest()
        if let requests = try? context.fetch(fetchReqest) {
            for request in requests {
                context.delete(request)
            }
        }
        do {
            try context.save()
            self.tableView.reloadData()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.isEmpty ? 0 : history.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? HistoryTableViewCell
        guard let historyCell = cell else { return UITableViewCell() }
        
        let searchRequests = history[indexPath.row]
        let searchRequest = searchRequests.searchRequest
        historyCell.historyRequestLabel.text = searchRequest

        return historyCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "historyRequestSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let dvc = segue.destination as? AlbumsCollectionViewController,
                  let searchRequest = history[indexPath.row].searchRequest else { return }
            dvc.historyRequest = searchRequest
            
        }
    }
    
    
}



