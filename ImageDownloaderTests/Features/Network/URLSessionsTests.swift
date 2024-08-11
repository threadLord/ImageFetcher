//
//  URLSessionsTests.swift
//  ImageDownloaderTests
//
//  Created by Marko on 7.8.24..
//

import XCTest
@testable import ImageDownloader

final class URLSessionsTests: XCTestCase {
    
    static let request = URLRequest(url: URL(string: "http://example.com/")!)
    
    func testAsync() async throws {
        StubUrlProtocol.observer = { request -> (HTTPURLResponse, Data?) in
            return (HTTPURLResponse(), "Awaited hello".data(using: .utf8)!)
        }
        
        // URLProtocol.registerClass makes this feel unnecessary,
        // but plenty of articles recommend setting .protocolClasses
        let cfg = URLSessionConfiguration.ephemeral
        cfg.protocolClasses = [StubUrlProtocol.self]
        let session = URLSession(configuration: cfg)
        
        let (received, _) = try await session.data(for: Self.request)
        let message = String(data: received, encoding: .utf8)
        XCTAssertEqual(message, "Awaited hello")
    }
}
