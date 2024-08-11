//
//  NetworkingManagerImageResponseSuccessMOCK.swift
//  ImageDownloader
//
//  Created by Marko on 9.8.24..
//

import Foundation
#if DEBUG

struct NetworkManagersImageMOCKSProvider {
    
    static func getNewtorkSuccess() -> NetworkManagerProtocol {
        let session = URLSessionProvider.getNewtorkSuccess()
        
        let networkManager = NetworkManager(session: session)
        
        return networkManager
    }
    
    static func getNewtorkNoData() -> NetworkManagerProtocol {
        let session = URLSessionProvider.getNewtorkNoData()
        let networkManager = NetworkManager(session: session)
        
        return networkManager
    }
    
    static func customNewtorkManagerk(response: HTTPURLResponse, data: Data?) -> NetworkManagerProtocol {
        
        let session = URLSessionProvider.customNewtorkManagerk(response: response, data: data)
        
        let networkManager = NetworkManager(session: session)
        
        return networkManager
    }
}
#endif
