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

    private let params: [String:Any] = ["api_key":"6612c1c2ce2d96fa707ae10e6b3bba43"]
    private let baseURL = Networking.baseURL.rawValue + Networking.topRated.rawValue
    
    func getVideoInfo(succes: @escaping ([Film])->(), fail: @escaping (String)->()) {
        Alamofire.request(baseURL, method: .get, parameters: params).responseJSON { (response) in
            if let error = response.error {
                fail(error.localizedDescription)
            } else {
                if let value = response.value {
                    succes(Film.parseJSON(json: JSON(value)))
                }
            }
        }
    }
    
    func getPosterImage (url _url: URL, succes: @escaping (UIImage)->(), fail: @escaping (String)->()) {
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
    
    func getMovieDetail (url _url: URL, succes: @escaping (FilmDetail)->(), fail: @escaping (String)->()) {
        Alamofire.request(_url, method: .get, parameters: params).responseJSON(queue: kUserInitiatedGQ) { (response) in
            if let error = response.error {
                fail(error.localizedDescription)
            } else {
                if let value = response.value {
//                    succes(FilmDetail.parseJSON(json: JSON(value)))
                    succes(FilmDetail(json: JSON(value))!)
                }
            }
        }
    }
    
}
