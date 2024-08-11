//
//  URLSessionProvider.swift
//  ImageDownloader
//
//  Created by Marko on 10.8.24..
//

import Foundation

#if DEBUG
struct URLSessionProvider {
    static func getNewtorkSuccess() -> URLSession {
        let toEncode = [ImageModelNetwork(id: 1, imageUrl: "http://")]
        
        StubUrlProtocol.observer = { request -> (HTTPURLResponse, Data?) in
            let encodedData = try JSONEncoder().encode(toEncode)
            return (HTTPURLResponse(), encodedData)
        }
 
        let cfg = URLSessionConfiguration.ephemeral
        cfg.protocolClasses = [StubUrlProtocol.self]
        let session = URLSession(configuration: cfg)
        return session
    }
    
    static func getNewtorkNoData() -> URLSession {
        StubUrlProtocol.observer = { request -> (HTTPURLResponse, Data?) in
            return (HTTPURLResponse(), nil)
        }
 
        let cfg = URLSessionConfiguration.ephemeral
        cfg.protocolClasses = [StubUrlProtocol.self]
        let session = URLSession(configuration: cfg)
        
        return session
    }
    
    static func customNewtorkManagerk(response: HTTPURLResponse, data: Data?) -> URLSession {
        StubUrlProtocol.observer = { request -> (HTTPURLResponse, Data?) in
            return (response, data)
        }
 
        let cfg = URLSessionConfiguration.ephemeral
        cfg.protocolClasses = [StubUrlProtocol.self]
        let session = URLSession(configuration: cfg)
                
        return session
    }
}
#endif
