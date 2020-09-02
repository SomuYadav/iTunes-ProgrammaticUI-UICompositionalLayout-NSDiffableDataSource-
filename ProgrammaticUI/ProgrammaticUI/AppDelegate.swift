//
//  AppDelegate.swift
//  ProgrammaticUI
//
//  Created by Apple on 23/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setRootVC()
        return true
    }
    
    //MARK: setRootVC
    /// it is setting the root ViewController
    func setRootVC() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.tintColor = globalAppTintColor
        let nav = UINavigationController(rootViewController: iTunesHomeVC())
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
}

