//
//  ImageCache.swift
//  ImageDownloader
//
//  Created by Marko on 5.8.24..
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private var cache = CacheDisk<Data>()
    private let cacheQueue = DispatchQueue(label: "cacheQueue")

    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        cacheQueue.async {
            if let cachedData = self.cache.value(forKey: url.absoluteString.replacingOccurrences(of: APIEnpoints.baseURLString, with: ""))?.value {
                DispatchQueue.main.async {
                    completion(UIImage(data: cachedData))
                }
            } else {
                self.downloadImage(url: url, completion: completion)
            }
        }
    }

    private func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
                        
            let _ = self.cache.save(data, forKey: url.absoluteString.replacingOccurrences(of: APIEnpoints.baseURLString, with: ""))
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
    func deleteCache(with keys: [String]) {
        cacheQueue.async {
            keys.forEach{  let _ = self.cache.deleteFromDisk(forKey:$0)}
            let _ =  self.cache.deleteAll()
        }
    }
}
