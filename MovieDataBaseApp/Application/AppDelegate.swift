//
//  AppDelegate.swift
//  MovieDataBaseApp
//
//  Created by Ashutosh Bisht on 27/07/24.
//

import UIKit
import AppCenter
import AppCenterCrashes
import AppCenterAnalytics

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           window = UIWindow(frame: UIScreen.main.bounds)
        
        AppCenter.start(withAppSecret: "23f564db-3cbc-49cd-a45f-d5138313c1ab", services: [
            Analytics.self,
            Crashes.self
        ])
        
        if Crashes.hasCrashedInLastSession {
            print("Crash detected in the last session.")
        }

           
           let appearance = UINavigationBarAppearance()
           appearance.backgroundColor = UIColor.systemBlue // Set your desired color
           appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
           appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
           
           UINavigationBar.appearance().standardAppearance = appearance
           UINavigationBar.appearance().scrollEdgeAppearance = appearance
           
           let viewController = MovieCategoryViewController()
           let navigationController = UINavigationController(rootViewController: viewController)
           window?.rootViewController = navigationController
           window?.makeKeyAndVisible()
           return true
       }
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


}

