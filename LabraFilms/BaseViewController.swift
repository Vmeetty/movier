//
//  BaseViewController.swift
//  LabraFilms
//
//  Created by vlad on 8/27/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    var films:[Any] = []
    var movieID = 0
    var filterFlag = Filter.topRated.rawValue
    var contentType = ContentType.Movies
    var spinnerFlag = true
    var moviePage = 1
    var seriesPage = 1
    var query: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customNibName = UINib(nibName: CellIDs.customCellID.rawValue, bundle: nil)
        myTableView.register(customNibName, forCellReuseIdentifier: CellIDs.customCellID.rawValue)
        let customMoreNibName = UINib(nibName: CellIDs.moreCustomCellID.rawValue, bundle: nil)
        myTableView.register(customMoreNibName, forCellReuseIdentifier: CellIDs.moreCustomCellID.rawValue)
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = 205

    }
    
    func updateVideos (contentType: ContentType, page: Int, query: String? = nil) {
        VideoProvider.sharedInstance.loadVideos(contentType: contentType, page: page, filter: self.filterFlag, query: query) { (results) in
            self.films.append(contentsOf: results)
            self.myTableView.reloadData()
            if self.films.count > 0 {
                self.configFooter()
            }
            self.spinnerFlag = false
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIDs.movieDetailSegueID.rawValue {
            if let detailVC = segue.destination as? MovieDetailViewController {
                detailVC.movieID = self.movieID
                detailVC.contentType = self.contentType
            }
        }
        else if segue.identifier == SegueIDs.searchSegueID.rawValue {
            if let searchVC = segue.destination as? SearchViewController {
                searchVC.setType(type: self.contentType)
            }
        }
    }
    
    @IBAction func filtrAction(_ sender: UIBarButtonItem) {
        ActionSheet.sharedInstance.configActionSheet(sender: self)
    }

    func configFooter () {
        let footerView = UIView.init(frame: CGRect(x: 0, y: 0, width: myTableView.frame.width, height: 100))
        let loadMoreButton = UIButton(type: .custom)
        loadMoreButton.setTitle("Load more", for: .normal)
        loadMoreButton.addTarget(self, action: #selector(loadMoreAction(button:)), for: .touchUpInside)
        loadMoreButton.setTitleColor(UIColor.gray, for: .normal)
        loadMoreButton.backgroundColor = UIColor.white
        loadMoreButton.frame = CGRect(x: 0, y: 0, width: myTableView.frame.width, height: 100)
        footerView.addSubview(loadMoreButton)
        myTableView.tableFooterView = footerView
    }
    
    func loadMoreAction (button: UIButton) {
        Caps.sharedInstance.configSpin(view: button)
        if contentType == .Movies {
            moviePage += 1
            updateVideos(contentType: contentType, page: moviePage, query: query)
        } else {
            seriesPage += 1
            updateVideos(contentType: contentType, page: seriesPage, query: query)
        }
    }

}

extension BaseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.customCellID.rawValue, for: indexPath) as! CustomTableViewCell
        if let movie = films[indexPath.row] as? Film {
            cell.film = movie
        } else if let series = films[indexPath.row] as? Series {
            cell.series = series
        }
        return cell
    }
}

extension BaseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let movie = films[indexPath.row] as? Film {
            movieID = movie.id
        } else if let series = films[indexPath.row] as? Series {
            movieID = series.id
        }
        performSegue(withIdentifier: SegueIDs.movieDetailSegueID.rawValue, sender: cell)
    }
}
