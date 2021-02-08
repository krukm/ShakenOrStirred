import SwiftUI

struct IconImageView: View {
    
    @ObservedObject private var imageLoader: ApiImageLoader
    
    public init(imageURL: URL?) {
        imageLoader = ApiImageLoader(resourseURL: imageURL)
    }
    
    public var body: some View {
        if let uiImage = UIImage(data: self.imageLoader.data)?.rounded
        {
            return AnyView(Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: ContentMode.fit))
        } else {
            return AnyView(Image(systemName: "multiply.circle.fill")
                            .onAppear(perform: { self.imageLoader.loadImage() }))
        }
    }
}

extension UIImage {
    var roundedImage: UIImage? {
        UIGraphicsBeginImageContext(size)
        UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)).addClip()
        self.draw(at: .zero)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
