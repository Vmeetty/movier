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
    
    // get movie
    func getMovie(with counter: Int, and params: [String:Any], succes: @escaping ([Film])->(), fail: @escaping (String)->()) {
        kUserInitiatedGQ.async {
            for id in counter...counter + 20 {
                Alamofire.request(Networking.baseURL.rawValue + "\(id)", method: .get, parameters: params).responseJSON { (response) in
                    if let error = response.error {
                        fail(error.localizedDescription)
                    } else {
                        if let value = response.value {
                            let movieInstance = Film.parseJSON(json: JSON(value))
                            kMainQueue.async {
                                succes(movieInstance)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getMovie(by externalID: Int, succes: @escaping (Film)->(), fail: @escaping (String)->()) {
        kUserInitiatedGQ.async {
            Alamofire.request(Networking.baseURL.rawValue + "\(externalID)", method: .get, parameters: self.params).responseJSON { (response) in
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
    }
    
    func getFiltered(type: ContentType, filter: String, params: [String:Any], succes: @escaping ([Any])->(), fail: @escaping (String)->()) {
        var baseURL = Networking.baseURL.rawValue
        if type == .Movies {
            baseURL = Networking.baseURL.rawValue
        } else {
            baseURL = Networking.baseURLserries.rawValue
        }
        Alamofire.request(baseURL + filter, method: .get, parameters: params).responseJSON { (response) in
            if let error = response.error {
                fail(error.localizedDescription)
            } else {
                if let value = response.value {
                    print(JSON(value))
                    if type == .Movies {
                        succes(Film.parseJSON(json: JSON(value)))
                    } else {
                        succes(Series.parseJSON(json: JSON(value)))
                    }
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
