//
//  ImageLoaderCoordinatorView.swift
//  ImageDownloader
//
//  Created by Marko on 6.8.24..
//

import SwiftUI

struct ImageLoaderCoordinatorView: View {
    @StateObject
    private var coordinator = ImageLoaderCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.buld(screen: .imageList)
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.buld(screen: screen)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.buld(sheet: sheet)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { fullscreenCover in
                    coordinator.buld(fullscreen: fullscreenCover)
                }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    ImageLoaderCoordinatorView()
}
