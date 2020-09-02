//
//  iTunesViewComposer.swift
//  ProgrammaticUI
//
//  Created by Apple on 24/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit

class ViewComposer: UIView {
    
    ///  it is representing a view
    enum ViewType {
        case songSubDetail(artist: String, date: String)
    }
    
    /// it is a Horizontal StacView which is made like SWiftUI's HStack
    lazy var HStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    convenience init(color: UIColor? = .label,_ fontStyle: UIFont.TextStyle,cotainerType: ViewType,spacing: CGFloat? = nil) {
        self.init()
        
        HStack.spacing = spacing ?? 10
        HStack.distribution = .fillProportionally
        addSubview(HStack)
        HStack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        func setUpSongDetail(_ artiestName: String,_ date: String) {
            
            let stack  = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 2
            
            let lblArtiestName  = UILabel()
            lblArtiestName.text = artiestName
            lblArtiestName.textColor = color
            lblArtiestName.textAlignment = .center
            lblArtiestName.font = UIFont.preferredFont(forTextStyle: fontStyle)
            
            let dot = UIView()
            
            let smallDot = UIView()
            smallDot.backgroundColor = color
            smallDot.layer.cornerRadius = 2
                   
            dot.addSubview(smallDot)
                   
            let lblDate  = UILabel()
            lblDate.text = date
            lblDate.textColor = color
            lblDate.textAlignment = .center
            lblDate.font = UIFont.preferredFont(forTextStyle: fontStyle)
            
            stack.addSubViews(views: [lblArtiestName,dot,lblDate,UIView.spacer()])
            
            HStack.addSubViews(views: [stack])
            
            dot.snp.makeConstraints { (make) in
                make.width.equalTo(10)
            }
            
            smallDot.snp.makeConstraints { (make) in
                make.width.height.equalTo(4)
                make.centerX.centerY.equalToSuperview()
            }
        }
        
        switch cotainerType {
          case .songSubDetail(let artist, let date):
            setUpSongDetail("\(artist)","\(date)")
        }
    }
}
