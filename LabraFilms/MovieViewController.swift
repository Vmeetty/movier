//
//  FirstViewController.swift
//  LabraFilms
//
//  Created by vlad on 8/22/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import UIKit

class MovieViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateVideos(contentType: .Movies, page: moviePage)
    }
}





// delete this

//extension MovieViewController: AddMoreMovieItems {
//    func addItems(model: Film) {
//        films.append(model)
////        myTableView.reloadData()
//    }
//}


























