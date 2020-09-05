//
//  iTunesSearchVC.swift
//  ProgrammaticUI
//
//  Created by Apple on 18/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit
import Moya

class iTunesSearchVC: UIViewController {
    
    /// necessadry to give one section, so declared it as main
    enum Section {
        case main
    }
    
    //MARK: - iTunesSearchVC UI Objects
    lazy var tbliTunes = UITableView()

     //MARK: - View Var(s)
    var datasource: UITableViewDiffableDataSource<Section,Result>!
    var snapshot = NSDiffableDataSourceSnapshot<Section,Result>()
    var loader = UIActivityIndicatorView(style: .medium)
    var cancellable: Cancellable?
    var showDetailHook: (Result) -> Void = { _ in}
    
    //MARK: - iTunesSearchVC View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    ///  search songs by  query, pass searched text in query
    /// - Parameter query: Search text
    func search(query: String) {
        cancellable?.cancel()
        loader.tintColor = .label
        self.loader.startAnimating()
        cancellable = iTunesSearchViewModel.getiTunessongs(searchsong: query) { result in
            self.tbliTunes.beginUpdates()
            self.loader.stopAnimating()
            switch result {
            case .success(let songs):
                self.snapshot.deleteAllItems()
                self.snapshot.appendSections([.main])
                self.snapshot.appendItems(songs, toSection: .main)
                self.datasource.apply(self.snapshot)
                
            case .failure:
                self.snapshot.deleteAllItems()
                self.snapshot.appendSections([.main])
                self.datasource.apply(self.snapshot)
            }
            self.tbliTunes.reloadData()
            
            self.tbliTunes.endUpdates()
        }
    }
    
    ///  when found search result then, push next controller by call back  because on presented controller you can't push your push controller
    /// - Parameter action: pass song info or object which is declared as item
    func showDetail(_ action: @escaping (Result) -> Void) {
        self.showDetailHook = action
    }
}
