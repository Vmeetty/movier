//
//  SearchViewController.swift
//  LabraFilms
//
//  Created by vlad on 8/28/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var searchSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        spinnerFlag = false
    }

    func searchContent (query: String) {
        VideoProvider.sharedInstance.searcher(contentType: contentType, query: query) { (results) in
            self.films = results
            self.myTableView.reloadData()
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keywords = searchBar.text
        searchContent(query: keywords!)
        searchBar.endEditing(true)
    }
}

