//
//  ActionButton.swift
//  ImageDownloader
//
//  Created by Marko on 6.8.24..
//

import SwiftUI

struct ActionButtonLabel: View {
    
    var systemName: String
    var body: some View {
        ZStack {
            Color.black.saturation(0.9)
                .clipShape(Circle())
                .shadow(color: .white, radius: 6)
            
            Image(systemName: systemName)
                .actionImage()
            
        }
        .frame(width: 64, height: 64)
    }
}

#Preview {
    ActionButtonLabel(systemName: "arrow.circlepath")
}
