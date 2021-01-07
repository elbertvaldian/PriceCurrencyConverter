//
//  AppDelegate.swift
//  SocialMediaDana
//
//  Created by Elbert Valdian Hardika on 15/10/19.
//  Copyright © 2019 Elbert Valdian Hardika. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
		window?.rootViewController = HomeRouter.createModule()
        window?.makeKeyAndVisible()

        return true
    }

    
}
