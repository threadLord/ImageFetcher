//
//  ImageListUITests.swift
//  ImageDownloaderUITests
//
//  Created by Marko on 8.8.24..
//

import XCTest

final class ImageListUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-networking-success":"1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_grid_has_correct_number_of_items_when_screen_loads() {
        let grid = app.otherElements["imageGrid"]
        XCTAssertTrue(grid.waitForExistence(timeout: 5), "LazyVGrid should be visible on ImageListView")
        
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let gridItems = grid.images.containing(predicate)
        XCTAssertEqual(gridItems.count, 1, "There should be 6 items on LazyVGrid")
        
        let textGridItems = grid.staticTexts.containing(predicate)
        XCTAssertTrue(textGridItems["Id: 1"].exists, "Should contain 1")
    }
    
    func test_actionButtons_exist_on_screen_loads() {
        let trashButton = app.buttons["button_trash"]
        let refreshButton = app.buttons["button_refresh"]
        XCTAssertTrue(trashButton.waitForExistence(timeout: 5), "Trash button should be present on the screen.")
        XCTAssertTrue(refreshButton.waitForExistence(timeout: 5), "Refresh button should be present on the screen.")
    }
    
    func test_grid_has_correct_number_of_items_when_screen_load_even_after_tapping_buttons_and_changing_env() {
        let trashButton = app.buttons["button_trash"]
        let refreshButton = app.buttons["button_refresh"]
        XCTAssertTrue(trashButton.waitForExistence(timeout: 5), "Trash button should be present on the screen.")
        XCTAssertTrue(refreshButton.waitForExistence(timeout: 5), "Refresh button should be present on the screen.")
        
        // Delete cache
        trashButton.tap()
        // change environment
        app.launchEnvironment = ["-networking-success":"0"]
        
        refreshButton.tap()
        
        // Check elements
        let grid = app.otherElements["imageGrid"]
        XCTAssertTrue(grid.waitForExistence(timeout: 5), "LazyVGrid should be visible on ImageListView")
        
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let gridItems = grid.images.containing(predicate)
        XCTAssertEqual(gridItems.count, 1, "There should be 6 items on LazyVGrid")
    }
    
    func test_ImageListToImageDetailsScreen_TapOnItem_ShouldPresentDetailsScreen() {
        let grid = app.otherElements["imageGrid"]
        XCTAssertTrue(grid.waitForExistence(timeout: 5), "LazyVGrid should be visible on ImageListView")
        
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let gridItems = grid.images.containing(predicate)
        XCTAssertEqual(gridItems.count, 1, "There should be 6 items on LazyVGrid")
        
        let textGridItems = grid.staticTexts.containing(predicate)
        XCTAssertTrue(textGridItems["Id: 1"].exists, "Should contain 1")
        textGridItems["Id: 1"].tap()
        
        let navigationView = app.otherElements["navigation_stack"]
        let navViewExist = navigationView.waitForExistence(timeout: 5)
        
        XCTAssertTrue(navViewExist, "NavigationView should be visible.")
    }
}
