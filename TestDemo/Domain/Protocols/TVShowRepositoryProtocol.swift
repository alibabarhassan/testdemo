import Foundation

protocol TVShowRepositoryProtocol {
    func getTVShowDetails(id: Int) async throws -> TVShow
    func getSeasonDetails(tvShowId: Int, seasonNumber: Int) async throws -> Season
}
