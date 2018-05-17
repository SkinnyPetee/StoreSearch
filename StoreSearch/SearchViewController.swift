//
//  ViewController.swift
//  StoreSearch
//
//  Created by sriram on 16/05/18.
//  Copyright © 2018 sriram. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{

   
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !(searchBar.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            searchBar.resignFirstResponder()
            searchResults = []
            if searchBar.text!  != "justin" {
            for i in 0...2 {
                    let searchResult = SearchResult()
                    searchResult.name = String(format: "Fake Result %d for", i)
                    searchResult.artistName = searchBar.text!
                    searchResults.append(searchResult)
                }
            }
            hasSearched = true
            tableView.reloadData()
        }
        
        
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    var searchResults: [SearchResult] = []

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var hasSearched = false
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if !hasSearched {
            return 0
        } else if searchResults.count == 0 {
            return 1
        } else {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
    func tableView(_ tableView: UITableView,
cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchResults.count == 0 {
            return tableView.dequeueReusableCell(
                withIdentifier: TableViewCellIdentifiers.nothingFoundCell,
                for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TableViewCellIdentifiers.searchResultCell,
                for: indexPath) as! SearchResultCell
            let searchResult = searchResults[indexPath.row]
            cell.nameLabel.text = searchResult.name
            cell.artistNameLabel.text = searchResult.artistName
            return cell
        }
    }
    
    
    
    
    struct TableViewCellIdentifiers {
        static let searchResultCell = "SearchResultCell"
        static let nothingFoundCell = "NothingCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
        tableView.rowHeight = 80
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0,
                                              right: 0)
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        var cellNib = UINib(nibName: TableViewCellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell,bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.nothingFoundCell)
    }
}




