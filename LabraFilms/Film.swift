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
    var title: String!
    var posterPath: String!
    var backdropPath: String!
    var average: Double!
    var overview: String!
    var id: Int!
    var releaseDate: String!
    
    init?(json: JSON) {
        
        if let title = json["original_title"].string {
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
        if let releaseDate = json["release_date"].string {
            self.releaseDate = releaseDate
        }
        if let overview = json["overview"].string {
            self.overview = overview
        }
        if let id = json["id"].int {
            self.id = id
        }
        
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
