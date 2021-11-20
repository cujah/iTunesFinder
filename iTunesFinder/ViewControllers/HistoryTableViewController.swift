//
//  HistoryTableViewController.swift
//  iTunesFinder
//
//  Created by Илья on 17.11.2021.
//

import UIKit

private let reuseIdentifier = "historyCell"

class HistoryTableViewController: UITableViewController {
    
    var viewModel: HistoryTableViewViewModelType?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = HistoryTableViewModel()
        viewModel?.getSearchRequestsHistory()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        self.title = "Search History"
    }
    
    @IBAction func clearHistoryButtonPressed(_ sender: Any) {
        alertOkCancel(title: "Clear the history?", message: "Press OK to clear the search history.") {
            self.viewModel?.clearHistory()
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? HistoryTableViewCell
        guard let historyCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.historyCellViewModel(forIndexPath: indexPath)
        historyCell.viewModel = cellViewModel
        return historyCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        performSegue(withIdentifier: "historyRequestSegue", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = viewModel else { return }
        if identifier == "historyRequestSegue" {
            if let dvc = segue.destination as? AlbumsCollectionViewController {
                dvc.viewModel = viewModel.viewModelForSelectedRow()
            }
        }
    }
}



