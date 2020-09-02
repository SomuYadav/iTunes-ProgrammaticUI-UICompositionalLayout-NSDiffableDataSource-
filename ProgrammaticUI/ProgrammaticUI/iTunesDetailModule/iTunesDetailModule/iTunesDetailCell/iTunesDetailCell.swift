//
//  PersonInfoCell.swift
//  ProgrammaticUI
//
//  Created by Apple on 19/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit
import SnapKit

class iTunesDetailInfoCell: UICollectionViewCell {
    
    //MARK: - superStack
    lazy var superStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    //MARK: - lblTitle
    lazy var lblTitle: UILabel = {
        let lblTitle  = UILabel()
        lblTitle.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        lblTitle.font = UIFont.boldSystemFont(ofSize: 30)
        lblTitle.textAlignment = .center
        lblTitle.numberOfLines = 2
        return lblTitle
    }()
    
    //MARK: - viewPrice
    lazy var viewPrice: UIView = {
        let viewPrice  = UIView()
        return viewPrice
    }()
    
    //MARK: - lblPrice
    lazy var lblPrice: UILabel = {
        let lblPrice  = UILabel()
        lblPrice.font = UIFont.boldSystemFont(ofSize: 18)
        lblPrice.textAlignment = .center
        lblPrice.backgroundColor = globalAppTintColor
        lblPrice.layer.cornerRadius = 15
        lblPrice.clipsToBounds = true
        lblPrice.textColor = .white
        lblPrice.numberOfLines = 2
        return lblPrice
    }()
  
    //MARK: - childStackView
    lazy var childStackView: UIView = {
        let stack = UIView()
        return stack
    }()
    
    //MARK: - imgSong
    lazy var imgSong: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    //MARK: - blurView
    lazy var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
        blurView.layer.cornerRadius  = 10
        blurView.layer.masksToBounds = true
        return  blurView
    }()
    
    //MARK: - btnPlay
    lazy var btnPlay: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle.fill"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitle("Play", for: UIControl.State.normal)
        button.backgroundColor = globalAppTintColor
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 0);
        button.layer.cornerRadius  = 20
        button.clipsToBounds = true
    
        return button
    }()
    
    //MARK: - btnPreviewSong
    lazy var btnPreviewSong: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("Related Songs", for: UIControl.State.normal)
        button.backgroundColor = globalAppTintColor
        button.layer.cornerRadius  = 10
        button.clipsToBounds = true
        button.layer.cornerRadius  = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    //MARK: - btnArtistSong
    lazy var btnArtistSong: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("Artist", for: UIControl.State.normal)
        button.backgroundColor = globalAppTintColor
        button.layer.cornerRadius  = 10
        button.clipsToBounds = true
        button.layer.cornerRadius  = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    //MARK: - previewArtistStackView
    lazy var previewArtistStackView: UIStackView = {
        let secondStackView = UIStackView()
        secondStackView.axis = .horizontal
        secondStackView.alignment = .center
        secondStackView.spacing = 20
        secondStackView.addSubViews(views: [btnArtistSong,btnPreviewSong])
        return secondStackView
    }()
    
    //MARK: - secondStackView
    lazy var secondStackView: UIStackView = {
        let secondStackView  = UIStackView()
        secondStackView.axis = .vertical
        secondStackView.alignment = .center
        secondStackView.spacing   = 30
        secondStackView.addSubViews(views: [UIView(),btnPlay])
        return secondStackView
    }()
    
    /// it is representing a ViewComposer which view is a stack and takes song artist and date
    var songDetail: (artist: String?,date: String?,trackCount: String)? = nil {
        didSet {
            guard let songDetail = songDetail else {return}
            self.superStack.addSubViews(views: [
                ViewComposer(.title3,cotainerType: .songSubDetail(artist: songDetail.artist ?? "", date: "\(songDetail.date?.getDate() ?? "")")),
                ViewComposer(.subheadline,cotainerType: .songSubDetail(artist: "Playlist", date: "\(songDetail.trackCount)")),
                viewPrice,secondStackView])
        }
    }
    
    override func prepareForReuse() {
        superStack.arrangedSubviews.forEach { if $0 is ViewComposer {$0.removeFromSuperview()}}
    }
    
    //MARK: -  Cell Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
