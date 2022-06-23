//
//  AppDelegate.swift
//  Zettel
//
//  Created by Vsevolod Moiseenkov on 11.10.2021.
//

import UIKit
import Firebase
//import IQKeyboardManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        IQKeyboardManager.shared().isEnabled = true
		FirebaseApp.configure()
		
        window = UIWindow()
        window?.rootViewController = LoginViewController()//tabBarController
        window?.makeKeyAndVisible()
        return true
    }

}

