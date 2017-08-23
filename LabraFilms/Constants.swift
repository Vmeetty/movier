//
//  Constants.swift
//  LabraFilms
//
//  Created by vlad on 8/22/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import Foundation

let filmCellID = "FilmTableViewCell"

// queues constants
let kUserInteractiveGQ = DispatchQueue.global(qos: .userInteractive)
let kUserInitiatedGQ = DispatchQueue.global(qos: .userInitiated)
let kUtilityGQ = DispatchQueue.global(qos: .utility)
let kBgQ = DispatchQueue.global(qos: .background)
let kDgQ = DispatchQueue.global()
let kMainQueue = DispatchQueue.main

// identifires for cells
enum CellIDs: String {
    case filmCellID = "FilmTableViewCell"
    case seriesCellID = "SeriesTableViewCell"
}

// segue identifires
enum SegueIDs: String {
    case movieDetailSegueID = "MovieDetailViewController"
}

// network stuff
enum Networking: String {
    case apiKey = "6612c1c2ce2d96fa707ae10e6b3bba43"
    case baseURL = "https://api.themoviedb.org/3/movie/"
    case movie = "3/movie/"
    case topRated = "top_rated"
    case baseURLposter = "https://image.tmdb.org/t/p/"
    case posterSize = "w370"
}
