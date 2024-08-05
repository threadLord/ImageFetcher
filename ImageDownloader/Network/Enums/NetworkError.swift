//
//  NetworkError.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case requestFailed
    case invalidRequest
}
