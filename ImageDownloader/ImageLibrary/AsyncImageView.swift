//
//  AsyncImageView.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL
    let placeholder: Image

    @State private var image: UIImage?

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            placeholder
                .aspectRatio(contentMode: .fit)
                .padding(16)
                .onAppear {
                    ImageCache.shared.loadImage(url: url) { loadedImage in
                        self.image = loadedImage
                    }
                }
        }
    }
}

#Preview {
    AsyncImageView(url: URL(string: "https://zipoapps-storage-test.nyc3.digitaloceanspaces.com/17_4691_besplatnye_kartinki_volkswagen_golf_1920x1080.jpg")!,
                   placeholder: Image(systemName: "photo"))
    .padding()
}
