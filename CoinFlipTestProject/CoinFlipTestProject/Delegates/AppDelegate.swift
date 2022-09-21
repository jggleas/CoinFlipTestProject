//
//  AppDelegate.swift
//  CoinFlipTestProject
//
//  Created by Jacob Gleason on 9/17/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window?.rootViewController = HomeViewController()
        // UserDefaults.standard.bool(forKey: "isOnboarded") ? HomeViewController() : OnboardingViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
