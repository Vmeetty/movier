//
//  FilmDetail.swift
//  LabraFilms
//
//  Created by vlad on 8/23/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import Foundation
import SwiftyJSON

class FilmDetail {
    let title: String!
    let picturePath: String!
    let overview: String!
    let releaseDate: String!
    
    init?(json: JSON) {
        guard let title = json["original_title"].string,
            let posterPath = json["backdrop_path"].string,
            let overview = json["overview"].string,
            let releaseDate = json["release_date"].string else {
                return nil
        }
        self.title = title
        self.picturePath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
}
