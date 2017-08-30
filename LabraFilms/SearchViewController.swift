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
        spinnerFlag = false
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keywords = searchBar.text
        query = keywords!
        if type == .Movies {
            updateVideos(contentType: type!, page: moviePage, query: query)
        } else {
            updateVideos(contentType: type!, page: seriesPage, query: query)
        }
        searchBar.endEditing(true)
    }
}

