//
//  NetworkManager.swift
//  LabraFilms
//
//  Created by vlad on 8/22/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    private init(){}
    
    func getMovie(url: String, type: ContentType, params: [String:Any], succes: @escaping (Any)->(), fail: @escaping (String)->()) {
        kUserInitiatedGQ.async {
            Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
                if let error = response.error {
                    fail(error.localizedDescription)
                } else {
                    if let value = response.value {
                        if type == .Movies {
                            if let filmInstance = FilmDetail(json: JSON(value)) {
                                succes(filmInstance)
                            }
                        } else {
                            if let seriesInstance = SeriesDetail(json: JSON(value)) {
                                succes(seriesInstance)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getVideos(type: ContentType, url: String, params: [String:Any], succes: @escaping ([Any])->(), fail: @escaping (String)->()) {
        kUserInitiatedGQ.async {
            Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
                if let error = response.error {
                    fail(error.localizedDescription)
                } else {
                    if let value = response.value {
                        if type == .Movies {
                            succes(Film.parseJSON(json: JSON(value)))
                        } else {
                            succes(Series.parseJSON(json: JSON(value)))
                        }
                    }
                }
            }
        }
    }
    
    func getPosterImage (url _url: URL, succes: @escaping (UIImage)->(), fail: @escaping (String)->()) {
        kUserInitiatedGQ.async {
            Alamofire.request(_url).response(queue: kUserInitiatedGQ) { (response) in
                if let error = response.error {
                    fail(error.localizedDescription)
                } else {
                    if let data = response.data, let image = UIImage(data: data) {
                        succes(image)
                    }
                }
            }
        }
    }
    
}
