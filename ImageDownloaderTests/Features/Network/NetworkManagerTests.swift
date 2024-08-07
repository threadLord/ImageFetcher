//
//  NetworkManagerTests.swift
//  ImageDownloaderTests
//
//  Created by Marko on 7.8.24..
//

import XCTest
@testable import ImageDownloader

final class NetworkManagerTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() async throws {
        let toEncode = ImageModelNetwork(id: 1, imageUrl: "http://")
        
        StubUrlProtocol.observer = { request -> (HTTPURLResponse, Data?) in
            let encodedData = try JSONEncoder().encode(toEncode)
            return (HTTPURLResponse(), encodedData)
        }
 
        let cfg = URLSessionConfiguration.ephemeral
        cfg.protocolClasses = [StubUrlProtocol.self]
        let session = URLSession(configuration: cfg)
        let request = URLRequest(url: URL(string: "http://example.com/")!)
        
        
        let networkManager = NetworkManager(session: session)
        let imageNetworkModel: ImageModelNetwork = try await networkManager.download(request: request, type: ImageModelNetwork.self)
       
        XCTAssertEqual(imageNetworkModel.imageUrl, toEncode.imageUrl)
    }
}
