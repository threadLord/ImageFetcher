//
//  ImageListViewModelTests.swift
//  ImageDownloaderTests
//
//  Created by Marko on 10.8.24..
//

import XCTest
@testable import ImageDownloader

final class ImageListViewModelTests: XCTestCase {
    var viewModel: ImageListViewViewModel!
     
     override func setUp() {
         super.setUp()
     }
     
     override func tearDown() {
         viewModel = nil
     }
     
    func testFetchImages_NetworkSuccess_ReturnImagesAndNetworkErrorNil() {
         // Given
         let networkManager = NetworkManagersImageMOCKSProvider.getNewtorkSuccess()
         viewModel = ImageListViewViewModel(networkManager: networkManager)
         // When
         viewModel.fetchImages()
         
         // Then
         // Verify that images are populated correctly
         // Replace with the expected count
         let expectation = XCTestExpectation(description: "test")
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 2.5)
         
         XCTAssertEqual(viewModel.images.count, 1)
         // Verify that networkError is nil
         XCTAssertNil(viewModel.networkError)
         
     }
     
     func testFetchImages_ResponseNoData_InvalidResponseAndImagesEmpty() {
         // Given
         let networkManager = NetworkManagersImageMOCKSProvider.getNewtorkNoData()
         viewModel = ImageListViewViewModel(networkManager: networkManager)
         
         // When
         viewModel.fetchImages()
         
         let expectation = XCTestExpectation(description: "test")
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 2.5)
         
         // Then
         // Verify that images remain empty
         XCTAssertTrue(viewModel.images.isEmpty)
         
         // Verify that networkError is set to .invalidRequest
         XCTAssertEqual(viewModel.networkError, .invalidResponse)
     }
     
     func testFetchImages_Response401_InvalidResponseAndImagesEmpty() {
         // Given
         let response = StubHTTPResponse.statusCode(code: 401).response
        
         let networkManager = NetworkManagersImageMOCKSProvider.customNewtorkManagerk(response: response, data: nil)
         viewModel = ImageListViewViewModel(networkManager: networkManager)
         
         // When
         viewModel.fetchImages()
         
         let expectation = XCTestExpectation(description: "test")
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 2.5)
         
         // Then
         // Verify that images remain empty
         XCTAssertTrue(viewModel.images.isEmpty)
         
         // Verify that networkError is set to .invalidResponse
         XCTAssertEqual(viewModel.networkError, .invalidResponse)
     }
}
