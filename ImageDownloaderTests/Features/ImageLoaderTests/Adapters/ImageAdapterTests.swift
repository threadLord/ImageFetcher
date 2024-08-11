//
//  ImageAdapterTests.swift
//  ImageDownloaderTests
//
//  Created by Marko on 10.8.24..
//

import XCTest
@testable import ImageDownloader

class ImageAdapterTests: XCTestCase {
    func testAdaptSingleImage_singleImage_ReturnEqualValues() {
        // Given
        let networkModel = ImageModelNetwork(id: 1, imageUrl: "https://example.com/image.jpg")
        let adapter = ImageAdapter()
        
        // When
        let adaptedModel = adapter.adapt(networkModel: networkModel)
        
        // Then
        XCTAssertEqual(adaptedModel.id, networkModel.id)
        XCTAssertEqual(adaptedModel.imageUrl, networkModel.imageUrl)
    }
    
    func testAdaptMultipleImages_multipleImage_ReturnEqualValues() {
        // Given
        let networkModels = [
            ImageModelNetwork(id: 1, imageUrl: "https://example.com/image1.jpg"),
            ImageModelNetwork(id: 2, imageUrl: "https://example.com/image2.jpg")
        ]
        let adapter = ImageAdapter()
        
        // When
        let adaptedModels = adapter.adapt(networkModels: networkModels)
        
        // Then
        XCTAssertEqual(adaptedModels.count, networkModels.count)
        XCTAssertEqual(adaptedModels[0].id, networkModels[0].id)
        XCTAssertEqual(adaptedModels[0].imageUrl, networkModels[0].imageUrl)
        XCTAssertEqual(adaptedModels[1].id, networkModels[1].id)
        XCTAssertEqual(adaptedModels[1].imageUrl, networkModels[1].imageUrl)
    }
}

