//
//  ImageLoaderCoordinatorTests.swift
//  ImageDownloaderTests
//
//  Created by Marko on 7.8.24..
//

import XCTest

import XCTest
@testable import ImageDownloader

class ImageLoaderCoordinatorTests: XCTestCase {
    var sut: ImageLoaderCoordinator!

    override func setUp() {
        super.setUp()
        sut = ImageLoaderCoordinator()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testPush() {
        let screen: Screen = .imageList
        sut.push(screen)
        XCTAssertEqual(sut.path.count, 1)
    }

    func testPresentSheet() {
        let sheet: Sheet = .none
        sut.present(sheet: sheet)
        XCTAssertEqual(sut.sheet, sheet)
    }

    func testPresentFullScreenCover() {
        let fullscreen: FullScreenCover = .fetchError
        sut.present(fullScreenCover: fullscreen)
        XCTAssertEqual(sut.fullScreenCover, fullscreen)
    }

    func testPop() {
        sut.push(.imageList)
        sut.pop()
        XCTAssertTrue(sut.path.isEmpty)
    }

    func testPopToRoot() {
        sut.push(.imageList)
        sut.push(.imageDetails(model: ImageModel(id: 1, imageUrl: "123")))
        sut.popToRoot()
        XCTAssertTrue(sut.path.isEmpty)
    }

    func testDismissSheet() {
        sut.present(sheet: .none)
        sut.dismissSheet()
        XCTAssertNil(sut.sheet)
    }

    func testDismissFullScreenCover() {
        sut.present(fullScreenCover: .fetchError)
        sut.dismissFullScreenCover()
        XCTAssertNil(sut.fullScreenCover)
    }
}
