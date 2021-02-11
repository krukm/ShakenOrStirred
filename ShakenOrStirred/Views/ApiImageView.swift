import SwiftUI

struct ApiImageView: View {
    
    @ObservedObject private var imageLoader: ApiImageLoader
    
    public init(imageURL: URL?) {
        imageLoader = ApiImageLoader(resourseURL: imageURL)
    }
    
    public var body: some View {
        if let uiImage = UIImage(data: self.imageLoader.data) {
            return AnyView(Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit))
        } else {
            return AnyView(Image(systemName: "waveform.circle.fill")
                            .onAppear(perform: { self.imageLoader.loadImage() }))
        }
    }
}
