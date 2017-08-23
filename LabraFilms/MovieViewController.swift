//
//  FirstViewController.swift
//  LabraFilms
//
//  Created by vlad on 8/22/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
 
    @IBOutlet weak var myTableView: UITableView!
    var films:[Film] = []
    var movieID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    func loadMovies () {
        NetworkManager.sharedInstance.getVideoInfo(succes: { (films) in
            self.films = films
            self.myTableView.reloadData()
        }) { (errorStr) in
            print(errorStr)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIDs.movieDetailSegueID.rawValue {
            if let detailVC = segue.destination as? MovieDetailViewController {
                detailVC.movieID = self.movieID
            }
        }
    }
    
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: filmCellID, for: indexPath) as! FilmTableViewCell
        cell.film = films[indexPath.row]
        return cell
    }
}

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: filmCellID, for: indexPath) as! FilmTableViewCell
        movieID = films[indexPath.row].id
        performSegue(withIdentifier: SegueIDs.movieDetailSegueID.rawValue, sender: cell)
    }
    
}


























