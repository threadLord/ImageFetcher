//
//  StubHTTPResponse.swift
//  ImageDownloader
//
//  Created by Marko on 10.8.24..
//

import Foundation

#if DEBUG

enum StubHTTPResponse {
    case statusCode(code: Int)
    
    var response: HTTPURLResponse {
        switch self {
        case .statusCode(code: let code):
            return HTTPURLResponse(url: URL(string: "http://code_\(code).com")!, statusCode: code, httpVersion: nil, headerFields: nil)!
        }
    }
}
#endif
