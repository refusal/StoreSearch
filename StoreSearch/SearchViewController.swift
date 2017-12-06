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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cellIdentifier = "SearchResultCell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if searchResults.count == 0 {
            cell.textLabel!.text = "Nothing found"
            cell.detailTextLabel!.text = ""
        } else{
            cell.textLabel!.text = searchResults[indexPath.row].name
            cell.detailTextLabel!.text = searchResults[indexPath.row].artistName
        }
       
        return cell
    }
    
}

extension SearchViewController : UISearchBarDelegate{
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        hasSearched = true
        searchBar.resignFirstResponder()
        searchResults = []
        
        if searchBar.text != "111"
        {
        for i in 0...2{
            let searchResult = SearchResult()
            searchResult.name = String(format:"Fake Result %d for", i)
            searchResult.artistName = searchBar.text!
            searchResults.append(searchResult)
            }
        }
        tableView.reloadData()
    }
}

