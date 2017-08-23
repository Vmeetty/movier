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

    var film: Film! {
        didSet {
            configCell()
        }
    }
    
    func configCell () {
        videoNameLabel.text = film.title
        averageLabel.text = String(film.average)
        descriptionLabel.text = film.overview
        posterConteinerView.layer.cornerRadius = 5
        posterConteinerView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFill
        if let url = URL(string: Networking.baseURLposter.rawValue + Networking.posterSize.rawValue + film.posterPath) {
            NetworkManager.sharedInstance.getPosterImage(url: url, succes: { (image) in
                kMainQueue.async {
                    self.posterImageView.image = image
                } 
            }, fail: { (errorStr) in
                print(errorStr)
            })
        }
    }
    
}
