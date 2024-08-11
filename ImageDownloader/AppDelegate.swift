//
//  AppDelegate.swift
//  ImageDownloader
//
//  Created by Marko on 8.8.24..
//

import UIKit


class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        #if DEBUG
        print("Is UI Test Running: \(UITestingHelper.isUITesting)")
        #endif
        
        return true
    }
}
