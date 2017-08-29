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

    func updateVideos (contentType: ContentType, page: Int) {
        VideoProvider.sharedInstance.loadFiltered(page: page, contentType: contentType, filter: self.filterFlag) { (result) in
            self.films.append(contentsOf: result)
            self.myTableView.reloadData()
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
    }
    
    @IBAction func filtrAction(_ sender: UIBarButtonItem) {
        ActionSheet.sharedInstance.configActionSheet(sender: self)
    }


}

extension BaseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.films.count {
            let moreCell = tableView.dequeueReusableCell(withIdentifier: CellIDs.moreCellID.rawValue) as! MoreTableViewCell
            moreCell.startSpinner = spinnerFlag
            return moreCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.filmCellID.rawValue, for: indexPath) as! FilmTableViewCell
            if let movie = films[indexPath.row] as? Film {
                if let posterPath = movie.posterPath {
                    let urlStr = Networking.baseURLposter.rawValue + Networking.posterSize.rawValue + posterPath
                    cell.imageURL = URL(string: urlStr)
                    cell.film = movie
                }
            } else if let series = films[indexPath.row] as? Series {
                if let posterPath = series.posterPath {
                    let urlStr = Networking.baseURLposter.rawValue + Networking.posterSize.rawValue + posterPath
                    cell.imageURL = URL(string: urlStr)
                    cell.series = series
                }
            }
            return cell
        }
    }
}

extension BaseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == self.films.count {
            let moreCell = tableView.cellForRow(at: indexPath) as! MoreTableViewCell
            if contentType == .Movies {
                moviePage += 1
                updateVideos(contentType: contentType, page: moviePage)
            } else {
                seriesPage += 1
                updateVideos(contentType: contentType, page: seriesPage)
            }
            moreCell.startSpinner = true
        } else {
            let cell = tableView.cellForRow(at: indexPath)
            if let movie = films[indexPath.row] as? Film {
                movieID = movie.id
            } else if let series = films[indexPath.row] as? Series {
                movieID = series.id
            }
            performSegue(withIdentifier: SegueIDs.movieDetailSegueID.rawValue, sender: cell)
        }
    }
}
