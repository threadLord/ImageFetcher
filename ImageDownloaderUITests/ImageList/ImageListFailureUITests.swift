//
//  ImageListFailureUITests.swift
//  ImageDownloaderUITests
//
//  Created by Marko on 10.8.24..
//

import XCTest

final class ImageListFailureUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-networking-success":"0"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_alert_is_show_when_screen_fails_to_load() {
        let navigationStack = app.otherElements["navigation_stack"]
        XCTAssertTrue(navigationStack.waitForExistence(timeout: 1), "There should be an alert on the screen")
        
        let grid = app.otherElements["imageGrid"]
        XCTAssertFalse(grid.waitForExistence(timeout: 5), "LazyVGrid should be visible on ImageListView")
    }
}
