//
//  iTunesDetailCellExtension.swift
//  ProgrammaticUI
//
//  Created by Apple on 23/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit

extension iTunesDetailInfoCell {
    
    /// Setting iTunesDetailInfoCell UI
    func setUI() {
        self.backgroundColor = .clear
        self.contentView.addSubview(superStack)
        self.superStack.addArrangedSubview(childStackView)
        self.childStackView.addSubview(blurView)
        self.blurView.contentView.addSubview(imgSong)
        self.superStack.addArrangedSubview(lblTitle)
        self.superStack.addArrangedSubview(viewPrice)
        self.viewPrice.addSubview(lblPrice)
        self.setConstraints()
    }
    
    /// Setting iTunesDetailInfoCell UI Constraints
    func setConstraints() {
        superStack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        childStackView.snp.makeConstraints { (make) in
            make.height.equalTo(UIScreen.main.bounds.width/1.5 + 20)
        }
        
        blurView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
            make.width.height.equalTo(UIScreen.main.bounds.width/1.5)
        }
        
        imgSong.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        viewPrice.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        lblPrice.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
        btnPlay.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        btnArtistSong.snp.makeConstraints { (make) in
            make.width.equalTo(140)
            make.height.equalTo(40)
        }
        
        btnPreviewSong.snp.makeConstraints { (make) in
            make.width.equalTo(140)
            make.height.equalTo(40)
        }
    }
    
    /// Configuring  iTunesDetailInfoCell or Setting data on UI
    /// - Parameter songDetail: it is song detail object
    func setConfig(_ songDetail: Result) {
        self.imgSong.sd_setImage(with: URL(string: songDetail.artworkUrl100 ?? ""))
        self.lblTitle.text = songDetail.trackName
        if let price = songDetail.trackPrice {
            self.lblPrice.text = songDetail.currency?.getPriceWithSymbol(price)
        } else {
            self.lblPrice.text  = "Free"
        }
    }
}
