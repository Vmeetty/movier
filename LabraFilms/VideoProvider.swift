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
    
    func getMovie (movieID: Int, contentType: ContentType, complitionHandler: @escaping (Any)->()) {
        let params: [String:Any] = ["api_key":Networking.apiKey.rawValue]
        NetworkManager.sharedInstance.getMovie(by: movieID, type: contentType, params: params, succes: { (movie) in
            kMainQueue.async {
                complitionHandler(movie)
            }
        }) { (errorStr) in
            print(errorStr)
        }
    }
    
    func loadFiltered (page: Int, contentType: ContentType, filter: String, complitionHandler: @escaping ([Any])->()) {
        let params: [String:Any] = ["api_key":Networking.apiKey.rawValue, "page":page]
        NetworkManager.sharedInstance.getFiltered(type: contentType, filter: filter, params: params, succes: { (result) in
            kMainQueue.async {
                complitionHandler(result)
            }
        }) { (errorStr) in
            print(errorStr)
        }
    }
    
    func getPicture (video: Any, complitionHandler: @escaping (UIImage) -> ()) {
        var backdropPath = ""
        if let movie = video as? Film {
            backdropPath = movie.backdropPath
        } else if let series = video as? Series {
            backdropPath = series.backdropPath
        }
        if let url = URL(string: Networking.baseURLposter.rawValue + Networking.posterSize.rawValue + backdropPath) {
            NetworkManager.sharedInstance.getPosterImage(url: url, succes: { (image) in
                kMainQueue.async {
                    complitionHandler(image)
                }
            }, fail: { (errorStr) in
                print(errorStr)
            })
        }
    }
    
    func searcher (contentType: ContentType, query: String, complitionHandler: @escaping ([Any]) -> ()) {
        let params: [String:Any] = ["api_key":Networking.apiKey.rawValue, "query":query]
        NetworkManager.sharedInstance.searchVideos(type: contentType, params: params, succes: { (results) in
            kMainQueue.async {
                complitionHandler(results)
            }
        }) { (error) in
            print(error)
        }
    }
    
    
    
    
}


















