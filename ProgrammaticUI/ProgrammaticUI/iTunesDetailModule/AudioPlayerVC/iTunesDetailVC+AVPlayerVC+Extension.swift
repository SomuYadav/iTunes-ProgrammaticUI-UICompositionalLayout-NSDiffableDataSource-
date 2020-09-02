//
//  iTunesDetailVC+AVPlayerVC+Extension.swift
//  ProgrammaticUI
//
//  Created by Apple on 24/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit
import AVKit

extension iTunesDetailVC {
    
    //MARK: setURLForAudioAndVideo()
    /// It is setting the minimizable AudioPayer
    @objc func setURLForAudioAndVideo() {
        //Player
        let songURL = URL(string: "\(self.iTunesSongModel.previewURL)")
        let player = AVPlayer(url: songURL!)
        let playerViewController = AVPlayerViewController()
        
        let view = setBackgroundView()
        playerViewController.contentOverlayView?.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        playerViewController.player = player
        
        //playerViewController.view.backgroundColor = .label
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    /// it will set the background of AVPlayerViewControlller
    /// - Returns: background view of player
    func setBackgroundView() -> UIView {
        let view = UIView()
        
        //MARK: - superStack
        let superStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .center
            stack.spacing = 10
            return stack
        }()
        
        //MARK: - lblTitle
        let lblTitle: UILabel = {
            let lblTitle  = UILabel()
            lblTitle.textColor = .white
            lblTitle.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            lblTitle.font = UIFont.boldSystemFont(ofSize: 30)
            lblTitle.textAlignment = .center
            lblTitle.numberOfLines = 2
            return lblTitle
        }()
        
        //MARK: - viewPrice
        let viewPrice: UIView = {
            let viewPrice  = UIView()
            return viewPrice
        }()
        
        //MARK: - lblPrice
        let lblPrice: UILabel = {
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
        let childStackView: UIView = {
            let stack = UIView()
            return stack
        }()
        
        //MARK: - imgSong
        let imgSong: UIImageView = {
            let img = UIImageView()
            img.contentMode = .scaleAspectFill
            return img
        }()
        
        //MARK: - blurView
        let blurView: UIVisualEffectView = {
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
            blurView.layer.cornerRadius  = 10
            blurView.layer.masksToBounds = true
            return  blurView
        }()
        
        view.addSubview(superStack)
        superStack.addArrangedSubview(childStackView)
        childStackView.addSubview(blurView)
        blurView.contentView.addSubview(imgSong)
        superStack.addArrangedSubview(lblTitle)
        superStack.addSubViews(views: [
            ViewComposer(color: .white,.title3,cotainerType: .songSubDetail(artist: iTunesSongModel.artistName?.lowercased().capitalized ?? "", date: "\(iTunesSongModel.releaseDate.getDate() ?? "")")),
            ViewComposer(color: .white,.subheadline,cotainerType: .songSubDetail(artist: "Playlist", date: "\(iTunesSongModel.trackCount ?? 0) Songs"))
        ])
        
        superStack.addArrangedSubview(viewPrice)
        imgSong.sd_setImage(with:  URL(string: self.iTunesSongModel.artworkUrl100 ?? ""))
        viewPrice.addSubview(lblPrice)
    
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
            
            func autoScroll() {
                    UIView.animate(withDuration: 12.0, delay: 1, options: ([.curveLinear, .repeat]), animations: {() -> Void in
                        lblTitle.center = CGPoint(x: 0 - lblTitle.bounds.size.width / 2,y: lblTitle.center.y)
                    }, completion:  { _ in
                        autoScroll()
                })
            }
        
            if (lblTitle.text?.widthOfString(usingFont: UIFont.boldSystemFont(ofSize: 30)) ?? 0) > UIScreen.main.bounds.size.width {
                autoScroll()
            }
        }

        /// Configuring  iTunesDetailInfoCell or Setting data on UI
        /// - Parameter songDetail: it is song detail object
        func setConfig(_ songDetail: Result) {
            imgSong.sd_setImage(with: URL(string: songDetail.artworkUrl100 ?? ""))
            lblTitle.text = songDetail.trackName
            if let price = songDetail.trackPrice {
                lblPrice.text = songDetail.currency?.getPriceWithSymbol(price)
            } else {
                lblPrice.text = "Free"
            }
        }
        
        setConfig(iTunesSongModel)
        setConstraints()
        
        return view
    }
}

//MARK:- UIButton Action  method implementation
extension iTunesDetailVC: AVPlayerViewControllerDelegate {
    
}


