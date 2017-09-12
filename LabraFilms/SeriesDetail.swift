//
//  SeriesDetail.swift
//  LabraFilms
//
//  Created by vlad on 9/11/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import Foundation
import SwiftyJSON

class SeriesDetail {
    var title = ""
    var picturePath = ""
    var overview = ""
    
    init?(json: JSON) {
        if let title = json["name"].string {
          self.title = title
        }
        if let posterPath = json["backdrop_path"].string {
            self.picturePath = posterPath
        }
        if let overview = json["overview"].string {
            self.overview = overview
        } else {
            self.overview = "Описание отсутствует..."
        }
    }
    
}
