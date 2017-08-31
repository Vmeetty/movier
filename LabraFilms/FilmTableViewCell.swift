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
            resetValues()
            configCell()
        }
    }
    var series: Series? {
        didSet {
            resetValues()
            configCell()
        }
    }
    var imageURL: URL?

    private func configCell () {
        if let url = imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                let contentsOfURL = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let movie = self.film {
                        if url == self.imageURL && movie === self.film {
                            if let imageData = contentsOfURL {
                                self.configUI(data: imageData, content: movie)
                            }
                            self.spinner.stopAnimating()
                            self.spinner.hidesWhenStopped = true
                        }
                    } else if let series = self.series {
                        if url == self.imageURL && series === self.series {
                            if let imageData = contentsOfURL {
                                self.configUI(data: imageData, content: series)
                            }
                            self.spinner.stopAnimating()
                            self.spinner.hidesWhenStopped = true
                        }
                    }
                    
                }
            }
        }
    }
    
    private func configUI (data: Data, content: Any) {
        self.posterImageView?.image = UIImage(data: data)
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
    
    func resetValues () {
        videoNameLabel.text = "..."
        averageLabel.text = nil
        descriptionLabel.text = "..."
        localTitle.text = nil
        posterImageView.image = nil
        posterConteinerView.backgroundColor = UIColor.gray
    }
    
}
