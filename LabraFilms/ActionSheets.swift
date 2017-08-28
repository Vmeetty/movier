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
    // optimize that func
    func configActionSheet (sender: UIViewController) {
        page = 1
        let actionSheet = UIAlertController(title: "Filter", message: "Choose any item", preferredStyle: .actionSheet)
        if let sender = sender as? MovieViewController {
            actionSheet.addAction(UIAlertAction(title: "Popular", style: .default, handler: { (action) in
                VideoProvider.sharedInstance.loadFiltered(page: 1, contentType: sender.contentType, filter: Filter.popular.rawValue, complitionHandler: { (films) in
                    sender.films = films
                    sender.filterFlag = Filter.popular.rawValue
                    sender.myTableView.reloadData()
                    let path = IndexPath(row: 0, section: 0)
                    sender.myTableView.scrollToRow(at: path, at: .top, animated: true)
                })
            }))
            actionSheet.addAction(UIAlertAction(title: "Top rated", style: .default, handler: { (action) in
                VideoProvider.sharedInstance.loadFiltered(page: 1, contentType: sender.contentType, filter: Filter.topRated.rawValue, complitionHandler: { (films) in
                    sender.films = films
                    sender.filterFlag = Filter.topRated.rawValue
                    sender.myTableView.reloadData()
                    let path = IndexPath(row: 0, section: 0)
                    sender.myTableView.scrollToRow(at: path, at: .top, animated: true)
                })
            }))
            actionSheet.addAction(UIAlertAction(title: "Now playing", style: .default, handler: { (action) in
                VideoProvider.sharedInstance.loadFiltered(page: 1, contentType: sender.contentType, filter: Filter.nowPlaying.rawValue, complitionHandler: { (films) in
                    sender.films = films
                    sender.filterFlag = Filter.nowPlaying.rawValue
                    sender.myTableView.reloadData()
                    let path = IndexPath(row: 0, section: 0)
                    sender.myTableView.scrollToRow(at: path, at: .top, animated: true)
                })
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (cancelAction) in
            }))
            sender.present(actionSheet, animated: true, completion: nil)
        }
        if let sender = sender as? SeriesViewController {
            actionSheet.addAction(UIAlertAction(title: "Popular", style: .default, handler: { (action) in
                VideoProvider.sharedInstance.loadFiltered(page: 1, contentType: sender.contentType, filter: Filter.popular.rawValue, complitionHandler: { (films) in
                    sender.films = films
                    sender.filterFlag = Filter.popular.rawValue
                    sender.myTableView.reloadData()
                    let path = IndexPath(row: 0, section: 0)
                    sender.myTableView.scrollToRow(at: path, at: .top, animated: true)
                })
            }))
            actionSheet.addAction(UIAlertAction(title: "Top rated", style: .default, handler: { (action) in
                VideoProvider.sharedInstance.loadFiltered(page: 1, contentType: sender.contentType, filter: Filter.topRated.rawValue, complitionHandler: { (films) in
                    sender.films = films
                    sender.filterFlag = Filter.topRated.rawValue
                    sender.myTableView.reloadData()
                    let path = IndexPath(row: 0, section: 0)
                    sender.myTableView.scrollToRow(at: path, at: .top, animated: true)
                })
            }))
            actionSheet.addAction(UIAlertAction(title: "Now playing", style: .default, handler: { (action) in
                VideoProvider.sharedInstance.loadFiltered(page: 1, contentType: sender.contentType, filter: Filter.onTheAir.rawValue, complitionHandler: { (films) in
                    sender.films = films
                    sender.filterFlag = Filter.onTheAir.rawValue
                    sender.myTableView.reloadData()
                    let path = IndexPath(row: 0, section: 0)
                    sender.myTableView.scrollToRow(at: path, at: .top, animated: true)
                })
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (cancelAction) in
            }))
            sender.present(actionSheet, animated: true, completion: nil)
        }
    }
    
}
