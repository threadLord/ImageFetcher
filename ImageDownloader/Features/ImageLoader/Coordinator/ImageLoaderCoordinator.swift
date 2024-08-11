//
//  ImageLoaderCoordinator.swift
//  ImageDownloader
//
//  Created by Marko on 6.8.24..
//

import SwiftUI


class ImageLoaderCoordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        guard !path.isEmpty else {
            return
        }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func buld(screen: Screen) -> some View {
        switch screen {
        case .imageList:
            ImageListView()
        case .imageDetails(let model):
            ImageDetailsScreen(model: model)
        }
    }
    
    @ViewBuilder
    func buld(sheet: Sheet) -> some View {
        switch sheet {
        case .none:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func buld(fullscreen: FullScreenCover) -> some View {
        switch fullscreen {
        case .fetchError:
            ImageErrorView() {
                self.fullScreenCover = nil
            }
            .accessibilityIdentifier("image_error")
        }
    }
}
