//
//  ImageErrorView.swift
//  ImageDownloader
//
//  Created by Marko on 7.8.24..
//

import SwiftUI

struct ImageErrorView: View {
    
    var action: () -> Void
    
    var body: some View {
        
        Color.red
            .frame(maxHeight: 200)
            .clipShape(.rect(cornerRadii: .init(topLeading: 8, bottomLeading: 8,bottomTrailing: 8, topTrailing: 8)))
            .overlay{
                VStack {
                    Spacer()
                    
                    Text("Error Fetching images!")
                        .modifier(ReadableTextModifier())
                    
                    Spacer()
                    
                    Button(action: action) {
                        Text("Ok")
                            .okButton()
                    }
                    .accessibilityIdentifier("image_error_view_ok_button")
                    .padding()
                }
            }
            .padding(.horizontal, 50)
            .shadow(color: .white, radius: 2)
            .background{
                Color.black.saturation(0.7)
                    .ignoresSafeArea()
            }
            .accessibilityIdentifier("image_error_view_background_color")
    }
}

#Preview {
    ImageErrorView(action: {
        print("Image error tapped")
    })
}
