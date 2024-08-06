//
//  ReadableTextModifier.swift
//  ImageDownloader
//
//  Created by Marko on 7.8.24..
//

import SwiftUI

struct ReadableTextModifier: ViewModifier {
    let color: Color
    let shadowColor: Color
    let radius: CGFloat
    
    init(color: Color = .white, shadowColor: Color = .black, radius: CGFloat = 1) {
        self.color = color
        self.shadowColor = shadowColor
        self.radius = radius
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
            .shadow(color: shadowColor, radius: radius)
    }
}
