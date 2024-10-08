//
//  ImageDetailsScreen.swift
//  ImageDownloader
//
//  Created by Marko on 6.8.24..
//

import SwiftUI
import ImageCachingLibrary

struct ImageDetailsScreen: View {
    
    @EnvironmentObject
    private var coordinator: ImageLoaderCoordinator
    
    let model: ImageModel
    
    var body: some View {
        let url = URL(string: model.imageUrl)!
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                AsyncImageView(url: url, 
                               placeholder: {
                                    Image(systemName: "photo").resizable()
                               },
                               imageClosure: { fetchedImage in
                                    Image(uiImage: fetchedImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                }
                )
                .accessibilityIdentifier("async_image_view_id_\(model.id)")
                .background(
                    ImageViewBackGround()
                )
                
                Text("Id: \(model.id)")
                    .accessibilityIdentifier("imageDetails_id_\(model.id)")
            }
            .frame(minHeight: 400)
            
            Spacer()
        }
        .accessibilityIdentifier("image_details_VStack")
    }
}

#Preview {
    ZStack {
        Color.black.brightness(0.7)
            .ignoresSafeArea()
        
        ImageDetailsScreen(model: ImageModel(id: 0,
                                             imageUrl:  "https://zipoapps-storage-test.nyc3.digitaloceanspaces.com/17_4691_besplatnye_kartinki_volkswagen_golf_1920x1080.jpg")
        )
        .padding(16)
    }
}
