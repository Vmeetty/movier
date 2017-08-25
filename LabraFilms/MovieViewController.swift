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
        
        // start animating spinner*******
        
        
        NetworkManager.sharedInstance.getLatestMovieID { (id) in
            self.loadMovies(latestMovieID: id)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        loadTopRatedMovies()
    }
    
    func loadMovies (latestMovieID: Int) {
        for id in 1...20 {
            NetworkManager.sharedInstance.getMovie (by: id, succes: { (film) in
                self.films.append(film)
                self.myTableView.reloadData()
            }) { (errorStr) in
                print(errorStr)
            }
        }
        
    }
    
    func loadTopRatedMovies () {
        NetworkManager.sharedInstance.getTopRated (succes: { (films) in
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
        if let posterPath = self.films[indexPath.row].posterPath {
            let urlStr = Networking.baseURLposter.rawValue + Networking.posterSize.rawValue + posterPath
            cell.imageURL = URL(string: urlStr)
            cell.film = films[indexPath.row]
        }
        
        return cell
    }
}

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        movieID = films[indexPath.row].id
        performSegue(withIdentifier: SegueIDs.movieDetailSegueID.rawValue, sender: cell)
    }
    
}


























