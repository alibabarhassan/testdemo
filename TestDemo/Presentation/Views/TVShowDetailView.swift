import SwiftUI

struct TVShowDetailView: View {
    @StateObject private var viewModel: TVShowDetailViewModel
    @EnvironmentObject private var appEnvironment: AppEnvironment
    @State private var showVideoPlayer = false
    
    init(viewModel: TVShowDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if viewModel.isLoading && viewModel.tvShow == nil {
                    LoadingView()
                } else if let error = viewModel.error, viewModel.tvShow == nil {
                    ErrorView(message: error) {
                        Task {
                            await viewModel.loadTVShowDetails()
                        }
                    }
                } else if let tvShow = viewModel.tvShow {
                    mainContent(tvShow: tvShow)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        Button(action: {}) {
                            Image(systemName: "tv")
                                .foregroundColor(.white)
                        }
                        Button(action: {}) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $showVideoPlayer) {
            VideoPlayerView(viewModel: appEnvironment.container.makeVideoPlayerViewModel())
        }
        .task {
            await viewModel.loadTVShowDetails()
        }
    }
    
    private func mainContent(tvShow: TVShow) -> some View {
        List {
            HeaderSection(tvShow: tvShow)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            
            ShowInfoSection(
                tvShow: tvShow,
                onPlay: { showVideoPlayer = true },
                onTrailer: { showVideoPlayer = true }
            )
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            
            DescriptionSection(overview: tvShow.overview)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            
            ActionButtonsSection()
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            
            SeasonEpisodesSection(
                seasons: viewModel.seasons,
                episodes: viewModel.episodes,
                selectedSeasonIndex: $viewModel.selectedSeasonIndex,
                onSeasonSelected: { index in
                    Task {
                        await viewModel.selectSeason(at: index)
                    }
                },
                onEpisodePlay: { showVideoPlayer = true }
            )
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
    }
}

// MARK: - Header Section
struct HeaderSection: View {
    let tvShow: TVShow
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImageView(url: tvShow.backdropURL)
                .frame(height: 400)
                .clipped()
            
            // Gradient overlay
            LinearGradient(
                gradient: Gradient(colors: [.clear, .black]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 200)
            
            // Title
            Text(tvShow.name)
                .font(.system(size: 42, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
        }
    }
}

// MARK: - Show Info Section
struct ShowInfoSection: View {
    let tvShow: TVShow
    let onPlay: () -> Void
    let onTrailer: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Year, Seasons, Rating
            HStack(spacing: 8) {
                Text(tvShow.year)
                Text("|")
                Text(tvShow.seasonsText)
                Text("|")
                Text("R")
            }
            .font(.subheadline)
            .foregroundColor(.gray)
            
            // Play and Trailer buttons
            HStack(spacing: 12) {
                PrimaryActionButton(title: "Play", icon: "play.fill", action: onPlay)
                SecondaryActionButton(title: "Trailer", icon: "play.rectangle", action: onTrailer)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
}

// MARK: - Description Section
struct DescriptionSection: View {
    let overview: String?
    
    var body: some View {
        if let overview = overview, !overview.isEmpty {
            ExpandableText(overview, lineLimit: 3)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
    }
}

// MARK: - Action Buttons Section
struct ActionButtonsSection: View {
    @State private var isInWatchlist = false
    @State private var isLiked = false
    @State private var isDisliked = false
    
    var body: some View {
        HStack(spacing: 32) {
            CircleIconButton(
                icon: "plus",
                label: "Watchlist",
                isSelected: isInWatchlist
            ) {
                isInWatchlist.toggle()
            }
            
            CircleIconButton(
                icon: "hand.thumbsup",
                label: "I like it",
                isSelected: isLiked
            ) {
                isLiked.toggle()
                if isLiked { isDisliked = false }
            }
            
            CircleIconButton(
                icon: "hand.thumbsdown",
                label: "I don't like it",
                isSelected: isDisliked
            ) {
                isDisliked.toggle()
                if isDisliked { isLiked = false }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 24)
        .glassCard(cornerRadius: 20)
        .padding(.horizontal, 16)
    }
}

// MARK: - Season Episodes Section
struct SeasonEpisodesSection: View {
    let seasons: [Season]
    let episodes: [Episode]
    @Binding var selectedSeasonIndex: Int
    let onSeasonSelected: (Int) -> Void
    let onEpisodePlay: () -> Void
    @Namespace private var episodeAnimation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Season tabs
            if !seasons.isEmpty {
                SeasonTabBar(
                    seasons: seasons,
                    selectedIndex: $selectedSeasonIndex,
                    onSeasonSelected: onSeasonSelected
                )
                .padding(.vertical, 16)
            }
            
            // Divider with glass effect
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.0),
                            Color.white.opacity(0.2),
                            Color.white.opacity(0.0)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 1)
                .padding(.horizontal, 16)
            
            // Episodes list with staggered animation
            LazyVStack(spacing: 8) {
                ForEach(Array(episodes.enumerated()), id: \.element.id) { index, episode in
                    EpisodeRowView(
                        episode: episode,
                        onPlay: onEpisodePlay,
                        onDownload: {},
                        index: index
                    )
                    .transition(.episodeTransition)
                }
            }
            .id(selectedSeasonIndex) // Force view recreation on season change
        }
    }
}

// MARK: - Custom Episode Transition
extension AnyTransition {
    static var episodeTransition: AnyTransition {
        .asymmetric(
            insertion: .modifier(
                active: EpisodeTransitionModifier(offset: 50, opacity: 0, scale: 0.9),
                identity: EpisodeTransitionModifier(offset: 0, opacity: 1, scale: 1)
            ),
            removal: .modifier(
                active: EpisodeTransitionModifier(offset: -50, opacity: 0, scale: 0.9),
                identity: EpisodeTransitionModifier(offset: 0, opacity: 1, scale: 1)
            )
        )
    }
}

// MARK: - Episode Transition Modifier
struct EpisodeTransitionModifier: ViewModifier {
    let offset: CGFloat
    let opacity: Double
    let scale: CGFloat
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset)
            .opacity(opacity)
            .scaleEffect(scale, anchor: .leading)
    }
}

#Preview {
    let container = DependencyContainer()
    TVShowDetailView(viewModel: container.makeTVShowDetailViewModel(tvShowId: container.configuration.defaultTVShowId))
        .environmentObject(AppEnvironment(container: container))
}
