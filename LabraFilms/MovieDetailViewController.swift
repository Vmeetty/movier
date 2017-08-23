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
        if let url = URL(string: Networking.baseURL.rawValue + String(self.movieID)) {
            NetworkManager.sharedInstance.getMovieDetail(url: url, succes: { (details) in
                self.titleLabel.text = details.title
                self.descriptionLabel.text = details.overview
                self.loadMoviePicture(details: details)
            }) { (errorStr) in
                print(errorStr)
            }
        }
    }
    
    func loadMoviePicture (details: FilmDetail) {
        if let url = URL(string: Networking.baseURLposter.rawValue + Networking.posterSize.rawValue + details.picturePath) {
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
