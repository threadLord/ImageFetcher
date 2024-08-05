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
                                RoundedRectangle(cornerRadius: 4, style: .circular)
                                    .fill(.black.opacity(0.9))
                                    .shadow(color: .white, radius: 1)
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
                        ZStack {
                            Color.black.saturation(0.9)
                                .clipShape(Circle())
                                .shadow(color: .white, radius: 6)
                            
                            Image(systemName: "trash")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(.white)
                            
                        }
                        .frame(width: 64, height: 64)
                    }
                    
                    Spacer()
                    
                    Button(action: imageListViewViewModel.fetchImages) {
                        ZStack {
                            Color.black.saturation(0.9)
                                .clipShape(Circle())
                                .shadow(color: .white, radius: 6)
                            
                            Image(systemName: "arrow.circlepath")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(.white)
                            
                        }
                        .frame(width: 64, height: 64)
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
