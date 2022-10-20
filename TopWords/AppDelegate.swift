//
//  AppDelegate.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 29/08/22.
//

import UIKit
import CoreData

 @main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let defaults = UserDefaults.standard
            let isPreloaded = defaults.bool(forKey: "isPreloaded")
            if !isPreloaded {
                print("Preloading data for the first time")
                preloadData()
                defaults.set(true, forKey: "isPreloaded")
            }
            return true
    }
   
    func preloadData() {
        
    let sourceSqliteURLs = [Bundle.main.url(forResource: "Model", withExtension: "sqlite"), Bundle.main.url(forResource: "Model", withExtension: "sqlite-wal"), Bundle.main.url(forResource: "Model", withExtension: "sqlite-shm")]

        let destSqliteURLs = [
            URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/Model.sqlite"),
            URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/Model.sqlite-wal"),
            URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/Model.sqlite-shm")]

        for index in 0...sourceSqliteURLs.count-1 {
            do {
                try FileManager.default.copyItem(at: sourceSqliteURLs[index]!, to: destSqliteURLs[index])
            } catch {
                print("Could not preload data")
            }
        }
    }
/*
    private func preloadData() {
        
        let preloadedDataKey = "didPreloadData"
        let userDefaults = 	UserDefaults.standard
        //if userDefaults.bool(forKey: preloadedDataKey) == false {
            //preload
            guard let urlPath = Bundle.main.url(forResource: "Model", withExtension: "sqlite")
            else { return
            }
            
            if let arrayContents = NSArray(contentsOf: urlPath) as? [String] {
                for Item in arrayContents {
                    print(Item)
                }
            }
            userDefaults.set(true, forKey: preloadedDataKey)
            
        //}
    }
*/
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {        
        let container = NSPersistentContainer(name: "Model")
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
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

