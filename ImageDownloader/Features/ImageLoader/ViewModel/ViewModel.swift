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
    private var imagelibraryWrapper: ImageLibraryWrapper
    
    init(networkManager: NetworkManagerProtocol = NetworkManager(),
         adapter: ImageAdapterProtocol = ImageAdapter(),
         imagelibraryWrapper: ImageLibraryWrapper = ImageLibraryWrapper()) {
        
        self.networkManager = networkManager
        self.adapter = adapter
        self.imagelibraryWrapper = imagelibraryWrapper
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
        imagelibraryWrapper.deleteCache(with: images.map{ $0.imageUrl })
    }
}
