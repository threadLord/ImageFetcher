//
//  UITestingHelper.swift
//  ImageDownloader
//
//  Created by Marko on 8.8.24..
//

#if DEBUG
import Foundation

struct UITestingHelper {
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
    
    static var isNetworkingSuccessful: Bool {
        ProcessInfo.processInfo.environment["-networking-success"] == "1"
    }
}
#endif
