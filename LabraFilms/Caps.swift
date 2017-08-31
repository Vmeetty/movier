//
//  LoadersAndCaps.swift
//  LabraFilms
//
//  Created by vlad on 8/31/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import UIKit

class Caps {
    
    static let sharedInstance = Caps()
    private init (){}

    let spinner = UIActivityIndicatorView()
    
    func configSpin (view: UIView) {
        spinner.isHidden = false
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        let width: CGFloat = 30
        let height: CGFloat = 30
        let x: CGFloat = (view.frame.width / 2) - (width / 2)
        let y: CGFloat = (view.frame.height / 2) - (height / 2)
        spinner.frame = CGRect(x: x, y: y, width: width, height: height)
        spinner.startAnimating()
        view.addSubview(spinner)
    }
    func removeSpin () {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    func configSpinner (enable: Bool, spiner: UIActivityIndicatorView?, label: UILabel, count: Int? = nil) {
        if let spiner = spiner {
            if enable {
                label.isHidden = true
                spiner.isHidden = false
                spiner.startAnimating()
            } else {
                spiner.isHidden = true
                spiner.stopAnimating()
                configCapLabel(count: count, label: label)
            }
        }
    }
    
    func configCapLabel (count: Int?, label: UILabel) {
        if count != nil {
            label.isHidden = false
            label.text = "Load more"
        } else if count == 0 {
            label.isHidden = false
            label.text = "There is no objects..."
        }else {
            label.isHidden = false
            label.text = "Try searching..."
        }
    }
    
}
