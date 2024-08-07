//
//  RequestCreatorTests.swift
//  ImageDownloaderTests
//
//  Created by Marko on 7.8.24..
//

import XCTest
@testable import ImageDownloader

class RequestCreatorTests: XCTestCase {
    func testCreateRequestWithValidURL() {
        let creator = RequestCreator.images(endPoint: "someEndpoint")
        let request = creator.request

        XCTAssertNotNil(request, "Request should not be nil")
    }

    func testCreateRequestWithInvalidURL() {
        let imageEndpoint = "image.jpg"
        let creator = RequestCreator.images(endPoint: imageEndpoint)
        let request = creator.request
        let apiURL = APIEnpoints.baseURLString + imageEndpoint

        XCTAssertEqual(request?.url?.absoluteString, apiURL, "URL should match the expected value")
    }
}
