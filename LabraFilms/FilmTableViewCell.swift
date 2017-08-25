//
//  FilmTableViewCell.swift
//  LabraFilms
//
//  Created by vlad on 8/22/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterConteinerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var localTitle: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var film: Film? {
        didSet {
            configCell()
        }
    }
    
    var imageURL: URL? {
        didSet {
            posterImageView?.image = nil
            configCell()
        }
    }
    
    private func configCell () {
        if let url = imageURL, let movie = film {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                let contentsOfURL = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if url == self.imageURL && movie === self.film {
                        if let imageData = contentsOfURL {
                            self.posterImageView?.image = UIImage(data: imageData)
                            self.posterImageView?.image = UIImage(data: imageData)
                            self.videoNameLabel.text = movie.title
                            self.averageLabel.text = String(movie.average)
                            self.descriptionLabel.text = movie.overview
                            self.posterConteinerView.layer.cornerRadius = 5
                            self.posterConteinerView.clipsToBounds = true
                            self.posterImageView.contentMode = .scaleAspectFill
                        }
                        self.spinner.stopAnimating()
                        self.spinner.hidesWhenStopped = true
                    }
                }
            }
        }
    }
    
}
