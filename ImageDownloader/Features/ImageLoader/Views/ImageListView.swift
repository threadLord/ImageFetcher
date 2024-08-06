//
//  ImageListView.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import SwiftUI
import ImageCachingLibrary

struct ImageListView: View {
    
    var imageListViewViewModel: ImageListViewViewModel = ImageListViewViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 8) {
                ForEach(imageListViewViewModel.images) { image in
                    let url = URL(string: image.imageUrl)!
                    VStack(alignment: .leading, spacing: 8) {
                        AsyncImageView(url: url, placeholder: Image(systemName: "photo").resizable())
                            .background(
                                ImageViewBackGround()
                            )
                        
                        Text("Id: \(image.id)")
                    }
                }
            }
            .padding()
        }
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
        .onAppear {
            imageListViewViewModel.fetchImages()
        }
    }
}

#Preview {
    ImageListView()
}
