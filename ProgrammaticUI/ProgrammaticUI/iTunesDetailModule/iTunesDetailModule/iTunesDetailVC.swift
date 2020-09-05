//
//  iTunesDetailVC.swift
//  ProgrammaticUI
//
//  Created by Apple on 19/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit

class iTunesDetailVC: UIViewController {
    
    // MARK: Internal enums
    /// it represent the collection view section
    enum Section: Int,Hashable, CaseIterable {
        case actions
        case portfolio
    }
    
    /// it represent the collection view cell
    enum RowType: Hashable {
        case saveButton
        case personInfo(songInfo: iTunesResult)
    }
    
    /// it represent what kind of axis you want in collection view cell
    enum Axis: Int {
        case horizontal
        case vertical
    }
    
    
    /// it represent what kind of viewcontroller
    enum ViewType {
        case saved(PersistModel)
        case online
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section,RowType>
    typealias Snapshot   = NSDiffableDataSourceSnapshot<Section,RowType>
    
    //MARK: -  View Var(s)
    var collectionView: UICollectionView!
    
    lazy var dataSource = createDataSource()
    lazy var snapShot   = Snapshot()
    var iTunesSongModel: Result!
    
    var type = ViewType.online
    lazy var imageView: UIImageView = {
        return UIImageView(image: UIImage(named: "image_name"))
    }()
    
    /// it represeting iTunes Song is save d in local storage or not
    var isSavedOnline: Bool {
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = doc[0].appendingPathComponent(self.iTunesSongModel.artistName ?? "")
        return FileManager.default.fileExists(atPath: path.path)
    }
    
    //MARK: -  View Life Cycle
    override func loadView() {
        super.loadView()
        UIView.transition(with: self.view, duration: 0.2, options: [.curveEaseInOut], animations: {
            self.setupUI()
            self.setupData()
        },completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.imageView.removeFromSuperview()
    }
    
    //MARK: -  setupUI()
    private func setupUI() {
        let layout = createCellLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        view.backgroundColor = .secondarySystemBackground
        self.collectionView.backgroundColor = .clear
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view).inset(10)
        }
        
        collectionView.delegate   = self
        collectionView.dataSource = self.dataSource
        collectionView.register(iTunesDetailInfoCell.self)
        collectionView.register(iTunesSaveOfflineCell.self)
        
        self.addBottomBar()
    }
    
    //MARK: -  setupData()
    /// set-up intial data and hook the view model listner to UI according to view type
    func setupData() {
        var title: String!
        
        self.snapShot.appendSections(Section.allCases)
        switch type {
        case .saved(let model):
            iTunesSongModel = model.item
            self.snapShot.appendItems([RowType.personInfo(songInfo: model.item)], toSection: .portfolio)
            self.dataSource.apply(self.snapShot)
            title  = model.item.trackName
            self.title = title?.getSubstringForHeader()
            self.dataSource.apply(self.snapShot)
        case .online:
            self.snapShot.appendItems([RowType.saveButton], toSection: .actions)
            self.snapShot.appendItems([RowType.personInfo(songInfo: self.iTunesSongModel)], toSection: .portfolio)
            self.dataSource.apply(self.snapShot)
            title  = self.iTunesSongModel?.trackName
            self.title = title?.getSubstringForHeader()
        }
        
        title  = iTunesSongModel.trackName
        self.title = title?.getSubstringForHeader()
        imageView.sd_setImage(with: URL(string: iTunesSongModel.artworkUrl100 ?? ""))
    }
    
    //MARK: -  createDataSource()
    ///  created datasource with three cells and intialize cell
    /// - Returns: it will return a UIDiffable datsource to assign UICollectionDatasource
    func createDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: self.collectionView) { (collectionView, indexPath, rowType) -> UICollectionViewCell? in
            
            switch rowType {
                
            case .personInfo(let songInfo):
                let cell = collectionView.dequeueReusableCell(ofType: iTunesDetailInfoCell.self, for: indexPath)
                cell.setConfig(songInfo)
                cell.songDetail = (songInfo.artistName,songInfo.releaseDate,"\(songInfo.trackCount ?? 1) Songs")
                cell.btnPlay.addTarget(self, action: #selector(self.setURLForAudioAndVideo), for: UIControl.Event.touchUpInside)
                return cell
            case .saveButton:
                let cell = collectionView.dequeueReusableCell(ofType: iTunesSaveOfflineCell.self, for: indexPath)
                cell.isOffline = self.isSavedOnline
                return cell
            }
        }
        return dataSource
    }
    
    //MARK: -  createCellLayout()
    /// create section(s) by UICollectionViewLayout
    /// - Returns: it is UICollectionViewLayout which will assign in collectionview layout
    func createCellLayout() -> UICollectionViewLayout {
         let layout = UICollectionViewCompositionalLayout { (sectionID, layoutEnviroment) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionID) else {
                fatalError("Invalid section id")
            }
            
            switch section {
                case .portfolio:
                    return self.createsongPortfolioSection()
                case .actions:
                    return self.createActionSection()
            }
        }
        return layout
    }
    
    //MARK: -  createSection()
    /// Crated number of section(s)
    /// - Parameters:
    ///   - isHeader: do you want?
    ///   - Count: Do you want grid of two or more
    ///   - axis: what kind of axis you want horizontal or vertical
    ///   - isItemSpacing: how much spacing you need to between items
    ///   - contentEdge: it will set view edges
    ///   - heightDimension: you have give estimated hight and it will be approx your cantent then it will increase automatically
    /// - Returns: NSCollectionLayoutSection it is a type of section which it returning a section
    func createSection(_ isHeader: Bool,_ Count: Int,_ axis: Axis,_ isItemSpacing: (Bool,CGFloat?), _ contentEdge: NSDirectionalEdgeInsets,_ heightDimension: CGFloat) -> NSCollectionLayoutSection {
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(heightDimension))
        let item      = NSCollectionLayoutItem(layoutSize: itemSize)
       
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(heightDimension))
        let group: NSCollectionLayoutGroup!
        
        switch axis {
            case .horizontal:
               group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: Count)
            case .vertical:
               group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        }
        
        if isItemSpacing.0 {
           group.interItemSpacing = .fixed(isItemSpacing.1!)
        }
        
        let section   = NSCollectionLayoutSection(group: group)
        section.contentInsets = contentEdge
        
        if isItemSpacing.0 {
           section.interGroupSpacing = isItemSpacing.1!
        }
        return section
    }
    
    //MARK: -  createsongPortfolioSection()
    ///  Created createsongPortfolioSection
    /// - Returns: it will return section
    func createsongPortfolioSection() -> NSCollectionLayoutSection {
        let edge = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        return self.createSection(false,0,.vertical,(false,nil),edge,130)
    }
    
    //MARK: - createsongPortfolioSection()
    /// Created createActionSection
    /// - Returns: it will return section
    func createActionSection() -> NSCollectionLayoutSection {
        let edge = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
        return self.createSection(false,0,.vertical,(false,nil),edge,50)
    }
}


