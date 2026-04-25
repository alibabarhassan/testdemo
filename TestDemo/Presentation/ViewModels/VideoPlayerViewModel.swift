import Foundation
import AVKit
import Combine

@MainActor
final class VideoPlayerViewModel: ObservableObject {
    @Published var player: AVPlayer?
    @Published var isPlaying = false
    
    private let videoURL: URL?
    
    init(urlString: String) {
        self.videoURL = URL(string: urlString)
    }
    
    func setupPlayer() {
        guard let url = videoURL else { return }
        player = AVPlayer(url: url)
    }
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func togglePlayback() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    func cleanup() {
        player?.pause()
        player = nil
        isPlaying = false
    }
}
