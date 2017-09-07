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
    var backView = UIView()
    
    func configSpin (view: UIView) {
        spinner.isHidden = false
        backView.isHidden = false
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        let width: CGFloat = 30
        let height: CGFloat = 30
        let x: CGFloat = (view.frame.width / 2) - (width / 2)
        let y: CGFloat = (view.frame.height / 2) - (height / 2)
        spinner.frame = CGRect(x: x, y: y, width: width, height: height)
        spinner.startAnimating()
        backView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        backView.backgroundColor = UIColor.white
        backView.addSubview(spinner)
        view.addSubview(backView)
    }
    func removeSpin () {
        spinner.stopAnimating()
        spinner.isHidden = true
        backView.isHidden = true
    }
    
    func configSpinner (enable: Bool, spiner: UIActivityIndicatorView?, button: UIButton, count: Int? = nil) {
        if let spiner = spiner {
            if enable {
                button.isHidden = true
                spiner.isHidden = false
                spiner.startAnimating()
            } else {
                spiner.isHidden = true
                spiner.stopAnimating()
                configCapLabel(count: count, button: button)
            }
        }
    }
    
    func configCapLabel (count: Int?, button: UIButton) {
        if count != nil {
            button.isHidden = false
            button.titleLabel?.text = "Load more"
        } else if count == 0 {
            button.isHidden = false
            button.titleLabel?.text = "There is no objects..."
        }else {
            button.isHidden = false
            button.titleLabel?.text = "Try searching..."
        }
    }
    
}
