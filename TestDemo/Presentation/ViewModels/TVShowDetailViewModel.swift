import Foundation
import Combine

@MainActor
final class TVShowDetailViewModel: ObservableObject {
    @Published private(set) var tvShow: TVShow?
    @Published private(set) var selectedSeason: Season?
    @Published private(set) var isLoading = false
    @Published private(set) var error: String?
    @Published var selectedSeasonIndex = 0
    
    private nonisolated(unsafe) let repository: TVShowRepositoryProtocol
    private let tvShowId: Int
    
    init(tvShowId: Int = 62852,
         repository: TVShowRepositoryProtocol = TVShowRepository()) {
        self.tvShowId = tvShowId
        self.repository = repository
    }
    
    var seasons: [Season] {
        tvShow?.seasons?.filter { $0.seasonNumber > 0 } ?? []
    }
    
    var episodes: [Episode] {
        selectedSeason?.episodes ?? []
    }
    
    func loadTVShowDetails() async {
        isLoading = true
        error = nil
        
        do {
            tvShow = try await repository.getTVShowDetails(id: tvShowId)
            
            // Load first season details by default
            if let firstSeason = seasons.first {
                await loadSeasonDetails(seasonNumber: firstSeason.seasonNumber)
            }
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func loadSeasonDetails(seasonNumber: Int) async {
        do {
            selectedSeason = try await repository.getSeasonDetails(
                tvShowId: tvShowId,
                seasonNumber: seasonNumber
            )
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func selectSeason(at index: Int) async {
        guard index < seasons.count else { return }
        selectedSeasonIndex = index
        let seasonNumber = seasons[index].seasonNumber
        await loadSeasonDetails(seasonNumber: seasonNumber)
    }
}
