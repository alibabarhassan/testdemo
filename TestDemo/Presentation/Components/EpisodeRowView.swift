import SwiftUI

struct EpisodeRowView: View {
    let episode: Episode
    let onPlay: () -> Void
    let onDownload: () -> Void
    let index: Int
    
    @State private var isVisible = false
    
    init(episode: Episode, onPlay: @escaping () -> Void, onDownload: @escaping () -> Void, index: Int = 0) {
        self.episode = episode
        self.onPlay = onPlay
        self.onDownload = onDownload
        self.index = index
    }
    
    var body: some View {
        rowContent
            .padding(.horizontal, 8)
            .opacity(isVisible ? 1 : 0)
            .offset(x: isVisible ? 0 : 30)
            .scaleEffect(isVisible ? 1 : 0.95, anchor: .leading)
            .onAppear {
                withAnimation(
                    .spring(response: 0.5, dampingFraction: 0.7)
                    .delay(Double(index) * 0.08)
                ) {
                    isVisible = true
                }
            }
    }
    
    @ViewBuilder
    private var rowContent: some View {
        if #available(iOS 26.0, *) {
            // iOS 26+ Liquid Glass
            HStack(spacing: 12) {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14, weight: .semibold))
                
                ZStack {
                    AsyncImageView(url: episode.stillURL)
                        .frame(width: 140, height: 80)
                        .clipped()
                        .cornerRadius(4)
                    
                    Button(action: onPlay) {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .frame(width: 44, height: 44)
                            .glassEffect(.regular.interactive(), in: .circle)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(episode.formattedTitle)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Button(action: onDownload) {
                    Image(systemName: "arrow.down.to.line")
                        .foregroundColor(.gray)
                        .font(.system(size: 18))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .glassEffect(.regular, in: .rect(cornerRadius: 12))
        } else {
            // Fallback for earlier versions
            HStack(spacing: 12) {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14, weight: .semibold))
                
                ZStack {
                    AsyncImageView(url: episode.stillURL)
                        .frame(width: 140, height: 80)
                        .clipped()
                        .cornerRadius(4)
                    
                    Button(action: onPlay) {
                        ZStack {
                            Circle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 44, height: 44)
                            
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(0.2),
                                            Color.white.opacity(0.05)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 44, height: 44)
                            
                            Circle()
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                .frame(width: 44, height: 44)
                            
                            Image(systemName: "play.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(episode.formattedTitle)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Button(action: onDownload) {
                    Image(systemName: "arrow.down.to.line")
                        .foregroundColor(.gray)
                        .font(.system(size: 18))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.ultraThinMaterial)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.05))
                    
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
                }
            )
        }
    }
}

#Preview {
    EpisodeRowView(
        episode: Episode(
            id: 1,
            name: "Tie Goes To The Runner",
            overview: "Test overview",
            stillPath: nil,
            episodeNumber: 1,
            seasonNumber: 1,
            airDate: "2016-01-17",
            voteAverage: 7.5,
            runtime: 60
        ),
        onPlay: {},
        onDownload: {}
    )
    .background(Color.black)
}
