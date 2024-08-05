//
//  APIEnpoints.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import Foundation

enum APIEnpoints {
    
    static var transferProtocol: String {
        do {
            let tp: String = try Configuration.value(for: ConfigKeys.transferProtocol.rawValue)
            return tp + "://"
        } catch {
            return ""
        }
    }
    
    static var baseURL: URL {
        let transferProtocol = APIEnpoints.transferProtocol
        return try! URL(string: transferProtocol  + Configuration.value(for: ConfigKeys.baseUrl.rawValue))!
    }
    
    static var baseURLString: String {
        do {
            let base: String = try Configuration.value(for: ConfigKeys.baseUrl.rawValue)
            let https = APIEnpoints.transferProtocol
            return https + base
        } catch {
            return ""
        }
    }
    
    static var imageListEndPoint: String {
        do {
            let imageListUrl: String = try Configuration.value(for: ConfigKeys.imageList.rawValue)
            return imageListUrl
        } catch {
            return ""
        }
    }
}
