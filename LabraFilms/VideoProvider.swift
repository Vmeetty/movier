//
//  VideoProvider.swift
//  LabraFilms
//
//  Created by vlad on 8/26/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import Foundation
import UIKit

class VideoProvider {
    
    static let sharedInstance = VideoProvider()
    private init(){}
    var counter = 1
    
    func getMovie (sender: UIViewController) {
        let params: [String:Any] = ["api_key":Networking.apiKey.rawValue]
        if let sender = sender as? MovieDetailViewController {
            NetworkManager.sharedInstance.getMovie(by: sender.movieID, params: params, succes: { (movie) in
                kMainQueue.async {
                    sender.titleLabel.text = movie.title
                    sender.descriptionLabel.text = movie.overview
                    sender.loadMoviePicture(movie: movie)
                }
            }) { (errorStr) in
                print(errorStr)
            }
        }
        
    }
    
    func loadFiltered (page: Int,
                       contentType: ContentType,
                       filter: String,
                       complitionHandler: @escaping ([Any])->()) {
        let params: [String:Any] = ["api_key":Networking.apiKey.rawValue, "page":page]
        NetworkManager.sharedInstance.getFiltered(type: contentType, filter: filter, params: params, succes: { (result) in
            complitionHandler(result)
        }) { (errorStr) in
            print(errorStr)
        }
    }
}
