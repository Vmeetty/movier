//
//  MovieDetailViewController.swift
//  LabraFilms
//
//  Created by vlad on 8/23/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movieID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieInfo()
    }
    
    func loadMovieInfo () {
        NetworkManager.sharedInstance.getMovie(by: self.movieID, succes: { (movie) in
            kMainQueue.async {
                self.titleLabel.text = movie.title
                self.descriptionLabel.text = movie.overview
                self.loadMoviePicture(movie: movie)
            }
        }) { (errorStr) in
            print(errorStr)
        }
    }
    
    func loadMoviePicture (movie: Film) {
        if let url = URL(string: Networking.baseURLposter.rawValue + Networking.posterSize.rawValue + movie.backdropPath) {
            NetworkManager.sharedInstance.getPosterImage(url: url, succes: { (image) in
                kMainQueue.async {
                    self.posterImageView.image = image
                    self.posterImageView.contentMode = .scaleAspectFill
                }
            }, fail: { (errorStr) in
                print(errorStr)
            })
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
