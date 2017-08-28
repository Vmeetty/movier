//
//  VideoProvider.swift
//  LabraFilms
//
//  Created by vlad on 8/26/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import Foundation

class VideoProvider {
    
    static let sharedInstance = VideoProvider()
    private init(){}
    var counter = 1
    
    func loadMovies (complitionHandler: @escaping (Film)->()) {
        for id in counter...counter + 20 {
            NetworkManager.sharedInstance.getMovie (by: id, succes: { (film) in
                complitionHandler(film)
            }) { (errorStr) in
                print(errorStr)
            }
        }
        counter += 21
    }
    
    func loadFiltered (page: Int,
                       contentType: ContentType,
                       filter: String,
                       complitionHandler: @escaping ([Any])->()) {
        let params: [String:Any] = ["api_key":"6612c1c2ce2d96fa707ae10e6b3bba43", "page": page]
        NetworkManager.sharedInstance.getFiltered(type: contentType, filter: filter, params: params, succes: { (result) in
            complitionHandler(result)
        }) { (errorStr) in
            print(errorStr)
        }
    }
}
