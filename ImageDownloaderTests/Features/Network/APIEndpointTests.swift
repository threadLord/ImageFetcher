//
//  APIEndpointTests.swift
//  ImageDownloaderTests
//
//  Created by Marko on 11.8.24..
//

import XCTest
@testable import ImageDownloader

final class APIEndpointTests: XCTestCase {
    // MARK: - Test transferProtocol
    
    func testTransferProtocol_ExpectedProtocol_ReturnEqualValues() {
        // Given
        let expectedProtocol = "https://"

        // When
        let actualProtocol = APIEnpoints.transferProtocol
        
        // Then
        XCTAssertEqual(actualProtocol, expectedProtocol)
    }
    
    // MARK: - Test baseURL
    
    func testBaseURL_ReadFromConfig_ReturnSameValue() {
        // Given
        let base: String = try! Configuration.value(for: ConfigKeys.baseUrl.rawValue)
        let https = APIEnpoints.transferProtocol
        let expectedBaseURLString = https + base
        
        // When
        let actualBaseURL = APIEnpoints.baseURL
        // Then
        XCTAssertEqual(actualBaseURL.absoluteString, expectedBaseURLString)
    }
    
    // MARK: - Test baseURLString
    
    func testBaseURLString_ReadFromConfing_ReturnSameValue() {
        // Given
        let base: String = try! Configuration.value(for: ConfigKeys.baseUrl.rawValue)
        let https = APIEnpoints.transferProtocol
        let expectedBaseURLString = https + base
        
        // When
        let actualBaseURLString = APIEnpoints.baseURLString
        
        // Then
        XCTAssertEqual(actualBaseURLString, expectedBaseURLString)
    }
    
    // MARK: - Test imageListEndPoint
    
    func testImageListEndPoint_ReadFromConfig_ReturnEqualValues() {
        // Given
        let expectedImageListEndPoint: String = try! Configuration.value(for: ConfigKeys.imageList.rawValue)
        
        // When
        let actualImageListEndPoint = APIEnpoints.imageListEndPoint
        
        // Then
        XCTAssertEqual(actualImageListEndPoint, expectedImageListEndPoint)
    }
}
