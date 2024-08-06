//
//  ActionImageModifier.swift
//  ImageDownloader
//
//  Created by Marko on 6.8.24..
//

import SwiftUI

extension Image {
    func actionImage(width: CGFloat = 32, height: CGFloat = 32, color: Color = .white) -> some View {
        self
            .renderingMode(.template)
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .foregroundStyle(color)            
    }
}
