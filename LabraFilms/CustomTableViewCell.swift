//
//  CustomTableViewCell.swift
//  LabraFilms
//
//  Created by vlad on 9/5/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterConteinerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var film: Film? {
        didSet {
            configCell()
        }
    }
    var series: Series? {
        didSet {
            configCell()
        }
    }
    
    override func prepareForReuse() {
        videoNameLabel.text = "..."
        averageLabel.text = nil
        descriptionLabel.text = "..."
        posterImageView.image = nil
        posterConteinerView.backgroundColor = UIColor.gray
    }
    
    private func configCell () {
        spinner.startAnimating()
        if let movie = film {
            if let posterPath = movie.posterPath {
                if let urlStr = URL(string: Networking.baseURLposter.rawValue + Networking.posterSize.rawValue + posterPath) {
                    kUserInitiatedGQ.async {
                        if let imageData = try? Data(contentsOf: urlStr) {
                            kMainQueue.async {
                                self.configUI(data: imageData, content: movie)
                                self.spinner.stopAnimating()
                                self.spinner.hidesWhenStopped = true
                            }
                        }
                    }
                }
            }
        } else if let series = series {
            if let posterPath = series.posterPath {
                if let urlStr = URL(string: Networking.baseURLposter.rawValue + Networking.posterSize.rawValue + posterPath) {
                    kUserInitiatedGQ.async {
                        if let imageData = try? Data(contentsOf: urlStr) {
                            kMainQueue.async {
                                self.configUI(data: imageData, content: series)
                                self.spinner.stopAnimating()
                                self.spinner.hidesWhenStopped = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func configUI (data: Data, content: Any) {
        self.posterImageView?.image = UIImage(data: data)
        if let movie = content as? Film {
            self.videoNameLabel.text = movie.title
            self.averageLabel.text = String(movie.average)
            self.descriptionLabel.text = movie.overview
        } else if let series = content as? Series {
            self.videoNameLabel.text = series.title
            self.averageLabel.text = String(series.average)
            self.descriptionLabel.text = series.overview
        }
        self.posterConteinerView.layer.cornerRadius = 5
        self.posterConteinerView.clipsToBounds = true
        self.posterImageView.contentMode = .scaleAspectFill
    }
    
}
