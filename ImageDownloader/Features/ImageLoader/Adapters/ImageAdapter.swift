//
//  ImageAdapter.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import Foundation

protocol ImageAdapterProtocol {
    func adapt(networkModel: ImageModelNetwork) -> ImageModel
    func adapt(networkModels: [ImageModelNetwork]) -> [ImageModel]
}

struct ImageAdapter: ImageAdapterProtocol {
    func adapt(networkModel: ImageModelNetwork) -> ImageModel {
        return ImageModel(id: networkModel.id, imageUrl: networkModel.imageUrl)
    }
    
    func adapt(networkModels: [ImageModelNetwork]) -> [ImageModel] {
        return networkModels.map{ adapt(networkModel: $0)}
    }
}
