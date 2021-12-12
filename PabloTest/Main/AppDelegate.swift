//
//  AppDelegate.swift
//  PabloTest
//
//  Created by Pablo Duarte on 10/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var rootViewController: UINavigationController {
        let navController = UINavigationController(rootViewController: UserViewController())
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.barTintColor = UIColor(red:56/255, green: 95/255, blue: 54/255, alpha: 1)
        return navController
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = rootViewController
        return true
    }
}
