//
//  StubUrlProtocol.swift
//  ImageDownloaderTests
//
//  Created by Marko on 7.8.24..
//

import Foundation

class StubUrlProtocol: URLProtocol {
    static var observer: ((URLRequest) throws -> (HTTPURLResponse , Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let observer = Self.observer else {
            return
        }

        do {
            let (response, data) = try observer(request)
            
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() { }
}
