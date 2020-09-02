//
//  iTunesSaveOfflineCell.swift
//  ProgrammaticUI
//
//  Created by Apple on 22/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit

class iTunesSaveOfflineCell: UICollectionViewCell {
    
    /// it is a save label title,which will show user have to save offline data or have to delate data from offline.
    lazy var lblSave: UILabel = {
        let lblSave  = UILabel()
        lblSave.textAlignment = .center
        lblSave.textColor = UIColor.label
        lblSave.font = UIFont.preferredFont(forTextStyle: .headline)
        return lblSave
    }()
    
    
    /// it is showing the status of user's offline and Set data   corresponding  to online/offline
    var isOffline: Bool = false {
        didSet {
            if isOffline {
                lblSave.text = "Delete From Offline"
                lblSave.textColor = .white
                self.blurView.contentView.backgroundColor = globalAppTintColor
            } else {
                lblSave.text = "Save Offline"
                lblSave.textColor = .label
                 self.blurView.contentView.backgroundColor = .clear
            }
        }
    }
    
    lazy var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
        return  blurView
    }()
    
     //MARK: -  cell Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(blurView)
        self.blurView.contentView.addSubview(lblSave)
        
        self.blurView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(0)
            make.trailing.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().inset(5)
        }
        
        self.lblSave.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        
        if isOffline {
            lblSave.text = "Delete From Offline"
            lblSave.textColor = .white
            self.blurView.contentView.backgroundColor = globalAppTintColor
        } else {
            lblSave.text = "Save Offline"
            lblSave.textColor = .label
            self.blurView.contentView.backgroundColor = .clear
        }
        
        self.blurView.layer.cornerRadius = 10
        self.blurView.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
