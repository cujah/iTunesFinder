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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchReqest: NSFetchRequest<SearchRequest> = SearchRequest.fetchRequest()
        do {
            history = try context.fetch(fetchReqest).reversed()
            self.tableView.reloadData()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
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

}



