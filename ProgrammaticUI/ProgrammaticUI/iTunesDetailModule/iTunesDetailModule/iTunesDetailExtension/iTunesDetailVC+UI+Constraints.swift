//
//  iTunesDetailExtension.swift
//  ProgrammaticUI
//
//  Created by Apple on 19/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit
import AVKit
import SafariServices

extension iTunesDetailVC {
    
    /// setLayout  for image and  empty text
    func setLayout() {
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 12.5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// set image constraints
    /// - Parameter navBar: set layout from nav bar
    func setImageConstraint(_ navBar: UINavigationBar) {
        imageView.snp.makeConstraints { (make) in
            make.right.equalTo(navBar).inset(Const.ImageRightMargin)
            make.bottom.equalTo(navBar).inset(Const.ImageBottomMarginForLargeState)
            make.height.equalTo(Const.ImageSizeForLargeState)
            make.width.equalTo(imageView.snp.height)
        }
    }
    
    /// set navigation bar
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(imageView)
        self.setLayout()
        self.setImageConstraint(navigationBar)
    }
}

extension iTunesDetailVC {
   
    ///  it is adding bottom artist song list button and preview button
    func addBottomBar() {
        let bottomHStack = UIStackView()
        bottomHStack.axis = .horizontal
        bottomHStack.alignment = .center
        bottomHStack.distribution = .fill
        
        let artistSong = UIButton()
        artistSong.tintColor = globalAppTintColor
        artistSong.setImage(UIImage(systemName: "music.note.list") , for: UIControl.State.normal)
        artistSong.addTarget(self, action: #selector(artistAudio), for: UIControl.Event.touchUpInside)
        
        let previewSong = UIButton()
        previewSong.tintColor = globalAppTintColor
        previewSong.setImage(UIImage(systemName: "music.note"), for: UIControl.State.normal)
        previewSong.addTarget(self, action: #selector(previewAudio), for: UIControl.Event.touchUpInside)
        
        self.view.addSubview(bottomHStack)
        bottomHStack.addSubViews(views: [artistSong,UIView.spacer(),previewSong])
        
        bottomHStack.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    /// it will show artist's preview
    @objc func previewAudio() {
        if let url =  self.iTunesSongModel.trackViewURL {
           let vc = SFSafariViewController(url: URL(string: url)!)
           self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    /// it will show artist play list
    @objc func artistAudio() {
        if let url = self.iTunesSongModel.artistViewURL {
           let vc  =  SFSafariViewController(url: URL(string: url)!)
           self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
}

