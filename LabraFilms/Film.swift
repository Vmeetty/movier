//
//  Film.swift
//  LabraFilms
//
//  Created by vlad on 8/22/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Film {
    let title: String!
    let posterPath: String!
    let average: Double!
    let overview: String!
    let id: Int!
    
    init?(json: JSON) {
        guard let title = json["original_title"].string,
            let average = json["vote_average"].double,
            let posterPath = json["poster_path"].string,
            let overview = json["overview"].string,
            let id = json["id"].int else {
                return nil
        }
        self.title = title
        self.average = average
        self.posterPath = posterPath
        self.overview = overview
        self.id = id
    }
    
    static func parseJSON (json: JSON) -> [Film] {
        var returnArray: [Film] = []
        if let resultArray = json["results"].array {
            for movie in resultArray {
                if let unwrapedJSON = Film(json: movie) {
                    returnArray.append(unwrapedJSON)
                }
            }
        }
        return returnArray
    }
}
