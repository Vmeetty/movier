//
//  MoreTableViewCell.swift
//  LabraFilms
//
//  Created by vlad on 8/25/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import UIKit

protocol AddMoreMovieItems {
    func addItems (model: Film)
}

class MoreTableViewCell: UITableViewCell {

    @IBOutlet weak var loadMoreLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var delegate: AddMoreMovieItems?
    var startSpinner: Bool? {
        didSet {
            configSpinner()
        }
    }
    
    func moreAction (model: Film) {
        delegate?.addItems(model: model)
    }

    func configSpinner () {
        if let startSpinner = self.startSpinner {
            if startSpinner {
                loadMoreLabel.isHidden = true
                spinner.isHidden = false
                spinner.startAnimating()
            } else {
                spinner.isHidden = true
                spinner.stopAnimating()
                loadMoreLabel.isHidden = false
            }
        }  
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

    }

}
