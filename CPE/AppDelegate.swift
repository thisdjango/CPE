//
//  AppDelegate.swift
//  CPE
//
//  Created by Diana Tsarkova on 02.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let viewController = EditorViewController()
        let navigation = UINavigationController(rootViewController: viewController)
                
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        // can use force unwrap
        window!.rootViewController = navigation
        window!.makeKeyAndVisible()
        
        return true
    }
}
