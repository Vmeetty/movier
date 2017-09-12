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
    var type: ContentType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setType (_ type: ContentType) {
        self.type = type
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.films.removeAll()
        let keywords = searchBar.text
        query = keywords!
        if let type = type {
            self.contentType = type
            updateVideos(contentType: type, page: 1, query: query)
        }
        searchBar.endEditing(true) 
    }
}

