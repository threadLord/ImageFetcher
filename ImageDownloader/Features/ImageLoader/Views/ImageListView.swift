//
//  ImageListView.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import SwiftUI
import ImageCachingLibrary

struct ImageListView: View {
    
    @EnvironmentObject
    private var coordinator: ImageLoaderCoordinator
    
    @StateObject
    var imageListViewViewModel: ImageListViewViewModel = ImageListViewViewModel()
    
    let layout = [
        GridItem(alignment: .bottom),
        GridItem(alignment: .bottom),
        GridItem(alignment: .bottom)
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: layout, spacing: 8) {
                ForEach(imageListViewViewModel.images) { image in
                    let url = URL(string: image.imageUrl)!
                    VStack(alignment: .leading, spacing: 8) {
                        
                        AsyncImageView(url: url, 
                                       placeholder: {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 100)
                                            
                                        }, 
                                       imageClosure: { fetchedImage in
                                            Image(uiImage: fetchedImage)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(height: 100)
                                        }
                        )
                        .background(
                            ImageViewBackGround()
                        )
                        
                        Text("Id: \(image.id)")
                    }
                    .onTapGesture {
                        coordinator.push(.imageDetails(model: image))
                    }
                }
            }
        }
        .padding()
        .overlay {
            VStack {
                Spacer()
                
                HStack {
                    Button(action: imageListViewViewModel.deleteCache) {
                        ActionButtonLabel(systemName: "trash")
                    }
                    
                    Spacer()
                    
                    Button(action: imageListViewViewModel.fetchImages) {
                        ActionButtonLabel(systemName: "arrow.circlepath")
                    }
                }
                .padding(24)
            }
        }
        .background(
            Color.black
        )
        .onChange(of: imageListViewViewModel.networkError) { old, newValue in
            if newValue != nil {
                coordinator.present(fullScreenCover: .fetchError)
            }
            
        }
        .onChange(of: coordinator.fullScreenCover) { old, newValue in
            if newValue == nil {
                imageListViewViewModel.networkError = nil
            }
        }
        .onAppear {
            imageListViewViewModel.fetchImages()
        }
    }
}

#Preview {
    ImageListView()
}
