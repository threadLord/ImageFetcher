//
//  ImageDownloaderApp.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import SwiftUI

@main
struct ImageDownloaderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ImageLoaderCoordinatorView()
        }
    }
}
