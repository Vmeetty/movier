//
//  SecondViewController.swift
//  LabraFilms
//
//  Created by vlad on 8/22/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import UIKit

class SeriesViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        contentType = .Serries
        updateVideos(contentType: contentType, page: seriesPage)
    }

}

