//
//  Screen.swift
//  ImageDownloader
//
//  Created by Marko on 6.8.24..
//

import Foundation

enum Screen: Identifiable, Hashable, Equatable {
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    var id: Screen {
        return self
    }
    
    case imageList
    case imageDetails(model: ImageModel)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .imageList:
            hasher.combine("imageList")
        case .imageDetails(let model):
            hasher.combine("imageDetails")
            hasher.combine(model.id)
        }
    }
}
