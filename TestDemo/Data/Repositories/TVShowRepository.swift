import Foundation

final class TVShowRepository: TVShowRepositoryProtocol, @unchecked Sendable {
    private let networkService: NetworkServiceProtocol
    
    nonisolated init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getTVShowDetails(id: Int) async throws -> TVShow {
        try await networkService.request(.tvShowDetails(id: id))
    }
    
    func getSeasonDetails(tvShowId: Int, seasonNumber: Int) async throws -> Season {
        try await networkService.request(.seasonDetails(tvShowId: tvShowId, seasonNumber: seasonNumber))
    }
}
