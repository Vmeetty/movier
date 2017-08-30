//
//  ActionSheets.swift
//  LabraFilms
//
//  Created by vlad on 8/26/17.
//  Copyright © 2017 vlad. All rights reserved.
//

import UIKit

class ActionSheet {
    
    static let sharedInstance = ActionSheet()
    private init () {}
    
    func configAction (by filter: String, sender: BaseViewController) {
        let path = IndexPath(row: 0, section: 0)
        VideoProvider.sharedInstance.loadVideos(contentType: sender.contentType, page: 1, filter: filter) { (films) in
            sender.films = films
            sender.filterFlag = filter
            sender.myTableView.reloadData()
            sender.myTableView.scrollToRow(at: path, at: .top, animated: true)
        }
    }
    
    func configActionSheet (sender: BaseViewController) {
        let actionSheet = UIAlertController(title: "Filter", message: "Choose any item", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Popular", style: .default, handler: { (action) in
            self.configAction(by: Filter.popular.rawValue, sender: sender)
        }))
        actionSheet.addAction(UIAlertAction(title: "Top rated", style: .default, handler: { (action) in
            self.configAction(by: Filter.topRated.rawValue, sender: sender)
        }))
        actionSheet.addAction(UIAlertAction(title: "Now playing", style: .default, handler: { (action) in
            var nowPlayingFilter = Filter.nowPlaying.rawValue
            if sender is MovieViewController {
                nowPlayingFilter = Filter.nowPlaying.rawValue
            } else if sender is SeriesViewController {
                nowPlayingFilter = Filter.onTheAir.rawValue
            }
            self.configAction(by: nowPlayingFilter, sender: sender)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        }))
        sender.present(actionSheet, animated: true, completion: nil)
    }

}
