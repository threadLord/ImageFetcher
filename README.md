**ImageFetcher App**

This app is used to test ImageCacheLibrary(https://github.com/threadLord/ImageCacheLibrary)

1. App has *ImageListView* where all downloaded images are listed.
   - On the bottom of the view there is a horizontal stack
   - On the left hand side you can find a button that removes the cache from the app
   - On the right hand side you can find a button that reloads images
   - If you want to test reset cache, scroll down to the bottom(because we use LazyVGrid), tap on the Remove cache button, than on the reload button

2. To use App properly follow these steps:
   - Go to File -> Packages -> Reset Packages Caches
   - Go to File -> Packages -> Update to Latest Packages Versions 


**App Overview**


App follows a horizontal architecture, where each feature is divided into separate folders that can be exported as independent libraries. The main feature is the ImageLoader, which consists of the following folders:

1. **ImageLibrary Wrapper:** Handles image caching and retrieval. Use ImageLibraryWrapperProtocol to wrap the library
``` Swift
protocol ImageLibraryWrapperProtocol {
    func deleteCache(with keys: [String])
}
```

2. **Coordinator:**  as *ImageLoaderCoordinator* Manages navigation and screen transitions within the ImageLoader feature.
ImageLoaderCoordinator uses functiality to navigate, present sheet and fullScreen

``` Swift
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
```


3. **Adapters:** Converts data models between different layers (e.g., network models to view models).
It uses *ImageAdapterProtocol*

``` Swift
protocol ImageAdapterProtocol {
    func adapt(networkModel: ImageModelNetwork) -> ImageModel
    func adapt(networkModels: [ImageModelNetwork]) -> [ImageModel]
}
``` 

5. **Model:** Contains data models related to images both NetworkModels and PresentedModels.

*PresentedModel* that implements Identifiable protocol:

``` Swift

struct ImageModel: Identifiable {
    var id: Int
    var imageUrl: String
}

```

*NetworkModel* that implements Codable protocol:

``` Swift

struct ImageModelNetwork: Codable {
    var id: Int
    var imageUrl: String
}


```

6. **ViewModel:** Implements business logic and manages the state for the image list.

 *images* - a list of images got from the server

*fetchImages()* - fetches images from the server

*deleteCache()* - deletes local cache

*NetworkManagerProtocol* - interface for a network layer provides dependency inversion so different implementations can be injected

*ImageAdapterProtocol* - interface for a image adapter provides dependency inversion so different implementations can be injected

*ImageLibraryWrapper* - interface for a Image library provides dependency inversion so different implementations can be injected. This allows easy change of the library and makes app totaly indepent to change the library if needed.

``` Swift
class ImageListViewViewModel: ObservableObject {
    
    @Published
    var images: [ImageModel] = []
    
    var networkError: NetworkError?
    
    private var networkManager: NetworkManagerProtocol
    private var adapter: ImageAdapterProtocol
    private var imagelibraryWrapper: ImageLibraryWrapper
    
    init(networkManager: NetworkManagerProtocol = NetworkManager(),
         adapter: ImageAdapterProtocol = ImageAdapter(),
         imagelibraryWrapper: ImageLibraryWrapper = ImageLibraryWrapper()) {
        
        self.networkManager = networkManager
        self.adapter = adapter
        self.imagelibraryWrapper = imagelibraryWrapper
    }

    func fetchImages()

    func deleteCache()

``` 
7. **Views:** Defines SwiftUI views related to displaying images.

*ImageLoaderCoordinatorView* - is a holder view of navigationStack for whole ImageLoader Feature. This is where Coordinator operates.

``` Swift
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
                .transaction { transaction in
                    transaction.disablesAnimations = true
                }
        }
        .accessibilityIdentifier("navigation_stack")
        .environmentObject(coordinator)
    }
}
```

*ImageListView*

1. coordinator: Coordinator is injected as EnvironmentObject
2. imageListViewViewModel is injected in all cases except when we use UITest where we resolve Network manager from NetworkManagersImageMOCKSProvider

``` Swift
struct ImageListView: View {
    
    @EnvironmentObject
    private var coordinator: ImageLoaderCoordinator
    
    @StateObject
    var imageListViewViewModel: ImageListViewViewModel
    
    init(imageListViewViewModel: ImageListViewViewModel = ImageListViewViewModel()) {
        
        #if DEBUG
        
        if UITestingHelper.isUITesting {
            var mock : NetworkManagerProtocol {
                if UITestingHelper.isNetworkingSuccessful {
                    return NetworkManagersImageMOCKSProvider.getNewtorkSuccess()
                } else {
                    return NetworkManagersImageMOCKSProvider.getNewtorkNoData()
                }
            }

            let vm = ImageListViewViewModel(networkManager: mock)
            self._imageListViewViewModel = StateObject(wrappedValue: vm)
        } else {
            self._imageListViewViewModel = StateObject(wrappedValue: imageListViewViewModel)
        }
        
        #else
        self._imageListViewViewModel = StateObject(wrappedValue: imageListViewViewModel)
        #endif
    }

```
3. LazyVGrid

*AsyncImageView* - loads images asynchronously. It accepts placeholder and Image as closure that provides fetched UIImage.

```Swift

ScrollView(.vertical) {
            LazyVGrid(columns: layout, spacing: 8) {
                ForEach(imageListViewViewModel.images) { image in
                    let url = URL(string: image.imageUrl)!
                    VStack(alignment: .leading, spacing: 8) {
                        
                        AsyncImageView(url: url, 
                                       placeholder: {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 100)
                                            
                                        }, 
                                       imageClosure: { fetchedImage in
                                            Image(uiImage: fetchedImage)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(height: 100)
                                        }
                        )
                        .background(
                            ImageViewBackGround()
                        )
                        
                        Text("Id: \(image.id)")
                    }
                    .onTapGesture {
                        coordinator.push(.imageDetails(model: image))
                    }
                    .accessibilityIdentifier("item_\(image.id)")
                }
            }
            .accessibilityIdentifier("imageGrid")
        }

```

4. Buttons stack:

*Trash button* - deletes cache
*Reload button* - Reloads image. If cache is delete previous to tapping button, new images will be fetched.

```Swift
VStack {
   Spacer()
                
   HStack {
      Button(action: imageListViewViewModel.deleteCache) {
                        ActionButtonLabel(systemName: "trash")
      }
      .accessibilityIdentifier("button_trash")
                    
      Spacer()
                    
      Button(action: imageListViewViewModel.fetchImages) {
            ActionButtonLabel(systemName: "arrow.circlepath")
      }
      .accessibilityIdentifier("button_refresh")

      }
      .padding(24)
}
```


*ImageDetailsScreen*

coordinator - Coordinator is injected as EnvironmentObject
    
model: ImageModel - Use presentable ImageModel that has identifiable protocol

AsyncImageView - Fetches the image from cache

Text - displays id of the image


``` Swift

struct ImageDetailsScreen: View {
    
    @EnvironmentObject
    private var coordinator: ImageLoaderCoordinator
    
    let model: ImageModel
...
}

```
