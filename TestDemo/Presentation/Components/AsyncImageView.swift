import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    let contentMode: ContentMode
    
    init(url: URL?, contentMode: ContentMode = .fill) {
        self.url = url
        self.contentMode = contentMode
    }
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)
        } placeholder: {
            Color.gray.opacity(0.3)
        }
    }
}

#Preview {
    AsyncImageView(url: nil)
        .frame(width: 200, height: 300)
}
