//
//  AppDelegate.swift
//  PabloTest
//
//  Created by Pablo Duarte on 10/12/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var rootViewController: UINavigationController {
        let navController = UINavigationController(rootViewController: UserViewController())
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.barTintColor = AppSettings.Color.darkGreen
        return navController
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = rootViewController
        return true
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
    }
}
