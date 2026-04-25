import Foundation

// MARK: - ImageLoadable Protocol
// Protocol for models that have images to load
protocol ImageLoadable {
    var imageURL: URL? { get }
    var placeholderImageName: String? { get }
}

extension ImageLoadable {
    var placeholderImageName: String? { nil }
}

// MARK: - BackdropImageLoadable Protocol
// Protocol for models that have backdrop images
protocol BackdropImageLoadable: ImageLoadable {
    var backdropURL: URL? { get }
}

extension BackdropImageLoadable {
    var imageURL: URL? { backdropURL }
}

// MARK: - ThumbnailImageLoadable Protocol
// Protocol for models that have thumbnail images
protocol ThumbnailImageLoadable: ImageLoadable {
    var thumbnailURL: URL? { get }
}

extension ThumbnailImageLoadable {
    var imageURL: URL? { thumbnailURL }
}
