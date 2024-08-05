//
//  RequestCreator.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import Foundation

enum RequestCreator {
    case images(endPoint: String = APIEnpoints.imageListEndPoint)

    var request: URLRequest? {
        switch self {
        case .images(let endPoint):
            let urlString: String = APIEnpoints.baseURLString + endPoint
            return createRequest(url: urlString)
        }
    }
    
    private func createRequest(url: String) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        return URLRequest(url: url)
    }
}
