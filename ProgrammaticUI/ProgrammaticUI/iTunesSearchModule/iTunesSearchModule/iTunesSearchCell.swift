//
//  iTunessongTableViewCell.swift
//  ProgrammaticUI
//
//  Created by Apple on 18/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit
import SnapKit

class iTunessongTableViewCell: UITableViewCell {
    
    //MARK: - iTunesSearchVC UI Objects
     /// intialized all object with lazy due delay in intialization
    lazy var superVStack: UIStackView = {
        let superVStack     = UIStackView()
        superVStack.axis    = .horizontal
        superVStack.spacing = 10
        superVStack.distribution = .fill
        superVStack.alignment    = .center
        return superVStack
    }()
    
    //MARK: - childVStack
    lazy var childVStack: UIStackView = {
        let childVStack = UIStackView()
        childVStack.axis = .vertical
        childVStack.distribution = .fill
        childVStack.spacing = 5
        return childVStack
    }()
    
    lazy var priceDurationVStack: UIStackView = {
        let superVStack     = UIStackView()
        superVStack.axis    = .horizontal
        superVStack.distribution = .fill
        return superVStack
    }()
    
    //MARK: - imgProfile
    lazy var imgProfile: UIImageView = {
        let imgProfile = UIImageView()
        imgProfile.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        imgProfile.layer.borderColor  = UIColor.gray.cgColor
        imgProfile.layer.borderWidth  = 1
        imgProfile.backgroundColor    = .lightGray
        imgProfile.layer.cornerRadius = 18.75 // magic number for corner 😇
        imgProfile.layer.masksToBounds = true
        return imgProfile
    }()
    
    //MARK: - lblName
    lazy var lblName: UILabel = {
        let lblName  = UILabel()
        lblName.font = UIFont.preferredFont(forTextStyle: .title3)
        lblName.textColor = .label
        return lblName
    }()
    
    //MARK: - lblURL
    lazy var lblURL: UILabel = {
        let lblURL  = UILabel()
        lblURL.font = UIFont.preferredFont(forTextStyle: .body)
        lblURL.textColor = .gray
        return lblURL
    }()
    
    //MARK: - lblGenre
    lazy var lblGenre: UILabel = {
        let lblGenre  = UILabel()
        lblGenre.font = UIFont.preferredFont(forTextStyle: .body)
        lblGenre.textColor = .gray
        return lblGenre
    }()
    
    //MARK: - lblDuration
    lazy var lblDuration: UILabel = {
        let lblDuration  = UILabel()
        lblDuration.font = UIFont.preferredFont(forTextStyle: .body)
        lblDuration.textColor = .gray
        return lblDuration
    }()
    
    //MARK: - lblPrice
    lazy var lblPrice: UILabel = {
        let lblPrice  = UILabel()
        lblPrice.font = UIFont.boldSystemFont(ofSize: 16)
        lblPrice.textColor = globalAppTintColor
        lblPrice.layer.cornerRadius = 5
        return lblPrice
    }()
    
    //MARK: - blurView
    lazy var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
        return  blurView
    }()
    
    //MARK: - View Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
