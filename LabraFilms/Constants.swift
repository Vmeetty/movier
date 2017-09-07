//
//  Constants.swift
//  LabraFilms
//
//  Created by vlad on 8/22/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import Foundation

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
    case moreCellID = "MoreTableViewCell"
    case customCellID = "CustomTableViewCell"
    case moreCustomCellID = "MoreCustomTableViewCell"
}

// segue identifires
enum SegueIDs: String {
    case movieDetailSegueID = "MovieDetailViewController"
    case searchSegueID = "SearchViewController"
}

// network stuff
enum Networking: String {
    case apiKey = "6612c1c2ce2d96fa707ae10e6b3bba43"
    case baseURL = "https://api.themoviedb.org/3/movie/"
    case baseURLserries = "https://api.themoviedb.org/3/tv/"
    case movie = "3/movie/"
    case topRated = "top_rated"
    case latest = "latest"
    case baseURLposter = "https://image.tmdb.org/t/p/"
    case posterSize = "w370"
}

enum SearchingBaseURLs: String {
    case searchMovieBaseURL = "https://api.themoviedb.org/3/search/movie"
    case searchSeriesBaseURL = "https://api.themoviedb.org/3/search/tv"
}

// filter flags
enum Filter: String {
    case popular = "popular"
    case topRated = "top_rated"
    case nowPlaying = "now_playing"
    case onTheAir = "on_the_air"
}

enum ContentType {
    case Movies
    case Serries
}

enum Page {
    case moviePage(page: Int)
    case seriesPage(page: Int)
}
