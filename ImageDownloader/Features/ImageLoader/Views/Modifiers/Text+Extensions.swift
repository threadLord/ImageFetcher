//
//  Text+Extensions.swift
//  ImageDownloader
//
//  Created by Marko on 7.8.24..
//

import SwiftUI

extension Text {
    func okButton() -> some View {
        self
        .foregroundStyle(.white)
        .padding(.horizontal, 40)
        .padding(.vertical, 8)
        .background {
            Color.black
        }
        .clipShape(.rect(cornerRadii: .init(topLeading: 8, bottomLeading: 8,bottomTrailing: 8, topTrailing: 8)))
        .shadow(color: .white, radius: 2)
    }
}

struct Text_Extensions: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    Text_Extensions()
}
