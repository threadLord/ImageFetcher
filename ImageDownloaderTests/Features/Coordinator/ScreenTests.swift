//
//  ScreenTests.swift
//  ImageDownloaderTests
//
//  Created by Marko on 11.8.24..
//

import XCTest
@testable import ImageDownloader

final class ScreenTests: XCTestCase {
    
    func testScreenTestsEnum_SameItems_ReturnEqualOnAssertion() {
        let imageList1 = Screen.imageList
        let imageList2 = Screen.imageList
        XCTAssertEqual(imageList1, imageList2, "imageList instances should be equal")
        
        let model = ImageModel(id: 42, imageUrl: "http://")
        let imageDetails1 = Screen.imageDetails(model: model)
        let imageDetails2 = Screen.imageDetails(model: model)
        XCTAssertEqual(imageDetails1, imageDetails2, "imageDetails instances should be equal")
    }
    
    func testHashing_givenDifferentImageModel_ReturnNotEqual() {
        let model1 = ImageModel(id: 42, imageUrl: "http://")
        let model2 = ImageModel(id: 42, imageUrl: "http:/")
        
        let imageDetails1 = Screen.imageDetails(model: model1)
        let imageDetails2 = Screen.imageDetails(model: model2)
        
        XCTAssertNotEqual(imageDetails1.hashValue, imageDetails2.hashValue, "Different models should have different hash values")
    }
    
    func testIdProperty_SameProperties_ReturnSameProperties() {
        let imageList = Screen.imageList
        XCTAssertEqual(imageList.id, imageList, "id property should return the same instance for imageList")
        
        let model = ImageModel(id: 42, imageUrl: "http://")
        let imageDetails = Screen.imageDetails(model: model)
        XCTAssertEqual(imageDetails.id, imageDetails, "id property should return the same instance for imageDetails")
    }
}
