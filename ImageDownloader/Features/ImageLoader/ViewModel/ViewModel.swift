//
//  ViewModel.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import Foundation
import ImageCachingLibrary

class ImageListViewViewModel: ObservableObject {
    
    @Published
    var images: [ImageModel] = []
    
    var networkError: NetworkError?
    
    private var networkManager: NetworkManagerProtocol
    private var adapter: ImageAdapterProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager(), adapter: ImageAdapterProtocol = ImageAdapter()) {
        self.networkManager = networkManager
        self.adapter = adapter
    }
    
    func fetchImages() {
        images = []
        
        guard let request: URLRequest = RequestCreator.images().request else {
            networkError = .invalidRequest
            return
        }
        
        Task {
            do {
                let imagesNetworkModel = try await self.networkManager.download(request: request, type: [ImageModelNetwork].self)
                
                let adaptedImages = self.adapter.adapt(networkModels: imagesNetworkModel)
                
                await MainActor.run {
                    images = adaptedImages
                }
            } catch is NetworkError {
                networkError = .invalidResponse
            }
        }
    }
    
    func deleteCache() {
        ImageCache.shared.deleteCache(with: images.map({ $0.imageUrl }))
    }
}
