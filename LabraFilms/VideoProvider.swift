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
    var params: [String:Any] = ["api_key":Networking.apiKey.rawValue]
    
    func getMovie(movieID: Int, contentType: ContentType, complitionHandler: @escaping (Any)->()) {
        var url = ""
        if contentType == .Movies {
            url = Networking.baseURL.rawValue
        } else {
            url = Networking.baseURLserries.rawValue
        }
        params[Params.page.rawValue] = nil
        params[Params.query.rawValue] = nil
        params[Params.includeAdult.rawValue] = nil
        params[Params.language.rawValue] = Networking.language.rawValue
        let finalURL = url + String(movieID)
        NetworkManager.sharedInstance.getMovie(url: finalURL, type: contentType, params: params, succes: { (movie) in
            kMainQueue.async {
                complitionHandler(movie)
            }
        }) { (errorStr) in
            print(errorStr)
        }
    }
    
    func loadVideos(contentType: ContentType, page: Int, filter: String?, query: String? = nil, complitionHandler: @escaping ([Any])->()) {
        var finalURL = ""
        params[Params.page.rawValue] = page
        params[Params.includeAdult.rawValue] = false
        params[Params.language.rawValue] = Networking.language.rawValue
        if let query = query {
            params[Params.query.rawValue] = query
            if contentType == .Movies {
                finalURL = SearchingBaseURLs.searchMovieBaseURL.rawValue
            } else {
                finalURL = SearchingBaseURLs.searchSeriesBaseURL.rawValue
            }
        } else if let filter = filter {
            if contentType == .Movies {
                finalURL = Networking.baseURL.rawValue + filter
            } else {
                finalURL = Networking.baseURLserries.rawValue + filter
            }
        }
        NetworkManager.sharedInstance.getVideos(type: contentType, url: finalURL, params: params, succes: { (result) in
            kMainQueue.async {
                complitionHandler(result)
            }
        }) { (errorStr) in
            print(errorStr)
        }
    }
    
    func getPicture (video: Any, complitionHandler: @escaping (UIImage) -> ()) {
        var backdropPath = ""
        if let movie = video as? FilmDetail {
            backdropPath = movie.picturePath
        } else if let series = video as? SeriesDetail {
            backdropPath = series.picturePath
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
    
}


















