import SwiftUI

struct SeasonTabBar: View {
    let seasons: [Season]
    @Binding var selectedIndex: Int
    let onSeasonSelected: (Int) -> Void
    @Namespace private var animation
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Array(seasons.enumerated()), id: \.element.id) { index, season in
                    SeasonTab(
                        title: "SEASON \(season.seasonNumber)",
                        isSelected: index == selectedIndex,
                        namespace: animation
                    ) {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            selectedIndex = index
                        }
                        onSeasonSelected(index)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SeasonTab: View {
    let title: String
    let isSelected: Bool
    var namespace: Namespace.ID
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundColor(isSelected ? .white : .gray)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    ZStack {
                        if isSelected {
                            slidingBackground
                                .matchedGeometryEffect(id: "seasonIndicator", in: namespace)
                        }
                    }
                )
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private var slidingBackground: some View {
        if #available(iOS 26.0, *) {
            // iOS 26+ - Use color overlay since glassEffect doesn't work well with matchedGeometry
            RoundedRectangle(cornerRadius: 8)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.orange.opacity(0.5),
                                    Color.orange.opacity(0.3)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.orange.opacity(0.6), lineWidth: 1)
                )
                .shadow(color: .orange.opacity(0.3), radius: 8, x: 0, y: 2)
        } else {
            // Fallback for earlier versions
            RoundedRectangle(cornerRadius: 8)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.orange.opacity(0.4),
                                    Color.orange.opacity(0.2)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.orange.opacity(0.6),
                                    Color.orange.opacity(0.2)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        }
    }
}

#Preview {
    @Previewable @State var selectedIndex = 0
    
    SeasonTabBar(
        seasons: [
            Season(id: 1, name: "Season 1", overview: nil, posterPath: nil, seasonNumber: 1, episodeCount: 20, airDate: nil, episodes: nil),
            Season(id: 2, name: "Season 2", overview: nil, posterPath: nil, seasonNumber: 2, episodeCount: 22, airDate: nil, episodes: nil),
            Season(id: 3, name: "Season 3", overview: nil, posterPath: nil, seasonNumber: 3, episodeCount: 23, airDate: nil, episodes: nil)
        ],
        selectedIndex: $selectedIndex,
        onSeasonSelected: { _ in }
    )
    .padding(.vertical, 20)
    .background(Color.black)
}
