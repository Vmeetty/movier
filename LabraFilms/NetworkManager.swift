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
    
    func getMovie(by externalID: Int, params: [String:Any], succes: @escaping (Film)->(), fail: @escaping (String)->()) {
        kUserInitiatedGQ.async {
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
