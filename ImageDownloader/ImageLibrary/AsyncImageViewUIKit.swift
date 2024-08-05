//
//  AsyncImageViewUIKit.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import UIKit

class AsyncImageViewUIKit: UIImageView {
    
    func loadImage(url: String, placeholder: String) {
        self.image = UIImage(named: placeholder)
        guard let url = URL(string: url) else {
            return
        }
        
        ImageCache.shared.loadImage(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
