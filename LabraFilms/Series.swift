//
//  Series.swift
//  LabraFilms
//
//  Created by vlad on 8/28/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import Foundation
import SwiftyJSON

class Series {
    var title: String!
    var posterPath: String!
    var backdropPath: String!
    var average: Double!
    var overview: String!
    var id: Int!
    
    init?(json: JSON) {
        
        if let title = json["name"].string {
            self.title = title
        }
        if let average = json["vote_average"].double {
            self.average = average
        }
        if let backdropPath = json["backdrop_path"].string {
            self.backdropPath = backdropPath
        }
        if let posterPath = json["poster_path"].string {
            self.posterPath = posterPath
        }
        if let overview = json["overview"].string {
            self.overview = overview
        }
        if let id = json["id"].int {
            self.id = id
        }
        
    }
    
    static func parseJSON (json: JSON) -> [Series] {
        var returnArray: [Series] = []
        if let resultArray = json["results"].array {
            for movie in resultArray {
                if let unwrapedJSON = Series(json: movie) {
                    returnArray.append(unwrapedJSON)
                }
            }
        }
        return returnArray
    }
    
}
