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
    
    //************
    // ***** fix that stuff. It's have to be put into enum or it's shoud be some list of params
    //    private let params: [String:Any] = ["api_key":"6612c1c2ce2d96fa707ae10e6b3bba43", "page":31]
    private let params: [String:Any] = ["api_key":"6612c1c2ce2d96fa707ae10e6b3bba43"]
    //************
    
    
    
    func getLatestMovieID (complition: @escaping (Int)->()) {
        Alamofire.request(Networking.baseURL.rawValue + Networking.latest.rawValue, method: .get, parameters: params).responseJSON { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            } else {
                if let value = response.value {
                    let json = JSON(value)
                    if let id = json["id"].int {
                        complition(id)
                    }
                }
            }
        }
    }
    
    // get movie
    func getMovie(by externalID: Int, succes: @escaping (Film)->(), fail: @escaping (String)->()) {
        Alamofire.request(Networking.baseURL.rawValue + "\(externalID)", method: .get, parameters: params).responseJSON { (response) in
            if let error = response.error {
                fail(error.localizedDescription)
            } else {
                if let value = response.value {
                    if let filmInstance = Film(json: JSON(value)) {
                        succes(filmInstance)
                    }
                }
            }
        }
    }
    
    func getTopRated(succes: @escaping ([Film])->(), fail: @escaping (String)->()) {
        Alamofire.request(Networking.baseURL.rawValue + Networking.topRated.rawValue, method: .get, parameters: params).responseJSON { (response) in
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
    
}
