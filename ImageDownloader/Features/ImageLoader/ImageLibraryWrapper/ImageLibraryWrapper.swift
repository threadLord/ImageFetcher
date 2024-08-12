//
//  ImageLibraryWrapper.swift
//  ImageDownloader
//
//  Created by Marko on 12.8.24..
//

import Foundation
import ImageCachingLibrary

struct ImageLibraryWrapper: ImageLibraryWrapperProtocol {
    func deleteCache(with urls: [String]) {
        ImageCache.shared.deleteCache(with: urls)
    }
}
