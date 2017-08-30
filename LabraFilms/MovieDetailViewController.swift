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
    var contentType: ContentType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieInfo()
    }
    
    func loadMovieInfo () {
        VideoProvider.sharedInstance.getMovie(movieID: self.movieID, contentType: contentType) { (result) in
            if let movie = result as? Film {
                self.titleLabel.text = movie.title
                self.descriptionLabel.text = movie.overview
                self.loadMoviePicture(movie: movie)
            } else if let series = result as? Series {
                self.titleLabel.text = series.title
                self.descriptionLabel.text = series.overview
                self.loadMoviePicture(movie: series)
            }
        }
    }
    
    func loadMoviePicture (movie: Any) {
        VideoProvider.sharedInstance.getPicture(video: movie) { (image) in
            self.posterImageView.image = image
            self.posterImageView.contentMode = .scaleAspectFill
        }
    }
    
}
