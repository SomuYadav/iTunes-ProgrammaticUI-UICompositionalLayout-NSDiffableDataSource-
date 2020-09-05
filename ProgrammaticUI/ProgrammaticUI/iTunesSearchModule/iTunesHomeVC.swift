//
//  iTunesHomeVC.swift
//  ProgrammaticUI
//
//  Created by Apple on 22/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit
import Moya

class iTunesHomeVC: UIViewController {
    
    //MARK: - iTunesSearchVC UI Objects
    lazy var tbliTunes = UITableView(frame: .zero, style: .grouped)
    
    enum Section{
        case main
    }
    
     //MARK: - View Var(s)
    var datasource: MyDataSource!
    var emptyTxt: UILabel!
    var snapshot = NSDiffableDataSourceSnapshot<Section,Result>()
    var persistModel: [PersistModel] {
        PersistModel.read()
    }
    
    //MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSearchController()
        self.setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.snapshot.deleteAllItems()
        self.snapshot.appendSections([Section.main])
        self.snapshot.appendItems(persistModel.map({ $0.item}), toSection: .main)
        self.datasource.apply(self.snapshot)
        self.emptyTxt.isHidden = self.persistModel.count > 0
    }
    
    //MARK: -  setSearchController
    /**
     * set another viewcontroller on setSearchController()
     *
     */
    func setSearchController() {
        let vc = iTunesSearchVC()
        vc.showDetail { item in
            let itunesDetailVC = iTunesDetailVC()
            itunesDetailVC.iTunesSongModel = item
            self.navigationController?.pushViewController(itunesDetailVC, animated: true)
        }
        
        let searchVC = UISearchController(searchResultsController: vc)
        searchVC.searchResultsUpdater = vc
        searchVC.obscuresBackgroundDuringPresentation = true
        searchVC.searchBar.placeholder = "Search song's"
        setNavBar(searchVC)
    }
    
    //MARK: -  setNavBar()
    func setNavBar(_ searchVC: UISearchController) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "iTunes Search"
        self.navigationItem.searchController = searchVC
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}
