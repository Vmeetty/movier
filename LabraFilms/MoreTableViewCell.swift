//
//  MoreTableViewCell.swift
//  LabraFilms
//
//  Created by vlad on 8/25/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    @IBOutlet weak var loadMoreLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var startSpinner: Bool! {
        didSet {
            configSpinner()
        }
    }
    var objectsCount: Int? = nil

    func configSpinner () {
        Caps.sharedInstance.configSpinner(enable: startSpinner, spiner: spinner, label: loadMoreLabel, count: objectsCount)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

    }

}
