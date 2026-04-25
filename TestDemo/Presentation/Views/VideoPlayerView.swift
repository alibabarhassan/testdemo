import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: VideoPlayerViewModel
    
    init(viewModel: VideoPlayerViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if let player = viewModel.player {
                VideoPlayer(player: player)
                    .ignoresSafeArea()
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
            
            // Close button overlay
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.cleanup()
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.white.opacity(0.8))
                            .padding()
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            viewModel.setupPlayer()
            viewModel.play()
        }
        .onDisappear {
            viewModel.cleanup()
        }
    }
}

#Preview {
    let container = DependencyContainer()
    VideoPlayerView(viewModel: container.makeVideoPlayerViewModel())
}
