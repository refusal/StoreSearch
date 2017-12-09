//
//  ViewController.swift
//  StoreSearch
//
//  Created by Slava Stepanov on 12/6/17.
//  Copyright © 2017 Slava Stepanov. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults = [SearchResult]()
    var hasSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.becomeFirstResponder()
        
        var cellNib = UINib(nibName: TableViewCellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.searchResultCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.nothingFoundCell)
        tableView.rowHeight = tableView.estimatedRowHeight
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ITunesUrl(searchText: Stiring)-> URL {
        let urlString = String(format: "https://itunes.apple.com/search?term=%@", searchText)
        let url = URL(fileURLWithPath: urlString)
        return url!
    }
}

extension SearchViewController : UITableViewDelegate{
    
}

extension SearchViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched {
            return 0
        }
        else if searchResults.count == 0 {
            return 1
        } else {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchResults.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.nothingFoundCell) as! NothingFoundCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.searchResultCell) as! SearchResultCell
            cell.nameLabel!.text = searchResults[indexPath.row].name
            cell.artistNameLabel!.text = searchResults[indexPath.row].artistName
            return cell
        }
    }
}

extension SearchViewController : UISearchBarDelegate{
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        if !searchBar.text!.isEmpty {
            searchBar.resignFirstResponder()
            
            hasSearched = true
            searchResults = []
            let url = ITunesUrl(searchText: searchBar.text!)
            print("URL: \(url)")
            tableView.reloadData()
        }
    }
}

struct TableViewCellIdentifiers{
    static let searchResultCell = "SearchResultCell"
    static let nothingFoundCell = "NothingFoundCell"
}

