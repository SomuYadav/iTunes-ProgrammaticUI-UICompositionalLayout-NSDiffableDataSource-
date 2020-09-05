//
//  iTunessongTableViewCell+Constraint+UI+Extension.swift
//  ProgrammaticUI
//
//  Created by Apple on 20/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import Foundation
import SDWebImage

//MARK: - iTunessongTableViewCell Model + UI + Constraints
extension iTunessongTableViewCell {
    //MARK: - setUpUI()
    func setUpUI() {
        self.backgroundColor = .clear
        self.blurView.layer.cornerRadius = 10
        self.blurView.clipsToBounds = true
        
        superVStack.addSubViews(views: [imgProfile,childVStack])
        childVStack.addSubViews(views: [lblName,lblURL,lblGenre,priceDurationVStack])
        priceDurationVStack.addSubViews(views: [lblDuration,UIView.spacer(),lblPrice])
        self.contentView.addSubview(blurView)
        blurView.contentView.addSubview(superVStack)
    }
    
    //MARK: - setUpConstraints()
    func setUpConstraints() {
           blurView.snp.makeConstraints { (make) in
               make.top.equalToSuperview().inset(5)
               make.bottom.equalToSuperview().inset(5)
               make.leading.equalToSuperview().inset(15)
               make.trailing.equalToSuperview().inset(15)
           }
           
           superVStack.snp.makeConstraints { (make) in
               make.edges.equalToSuperview().inset(15)
           }
           
           imgProfile.snp.makeConstraints { (make) in
               make.width.height.equalTo(110)
        }
    }
    
    //MARK: - configCellWithModel()
    func configCellWithModel(_ song: Result) {
        self.lblName.text  = song.trackName?.capitalized
        self.lblURL.attributedText = AttributedString.setAttributedString("Artist. ",song.artistName?.capitalized ?? "")
        self.lblDuration.text = TimeInterval(exactly: song.trackTimeMillis ?? 0)?.minuteSecondMS
        self.imgProfile.sd_setImage(with: URL(string: song.artworkUrl100 ?? ""))
        
        if let genre = song.primaryGenreName?.capitalized {
            self.lblGenre.attributedText = AttributedString.setAttributedString("Genre. ",genre)
        }
        
        if let price = song.trackPrice {
            self.lblPrice.text = song.currency?.getPriceWithSymbol(price)//(price.getPriceWithSymbol)
        } else {
            self.lblPrice.text  = "Free"
        }
    }
    
    //MARK: - configureCell()
    func configureCell() {
        self.setUpUI()
        self.setUpConstraints()
    }
}
