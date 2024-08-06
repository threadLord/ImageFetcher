//
//  ImageViewBackGround.swift
//  ImageDownloader
//
//  Created by Marko on 6.8.24..
//

import SwiftUI

struct ImageViewBackGround: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 4, style: .circular)
            .fill(.black.opacity(0.9))
            .shadow(color: .white, radius: 1)
    }
}
