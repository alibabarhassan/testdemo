import Foundation

// MARK: - MediaContent Protocol
// Base protocol for all media content (TV Shows, Movies, etc.)
protocol MediaContent: Identifiable, Codable {
    var id: Int { get }
    var title: String { get }
    var overview: String? { get }
    var rating: Double? { get }
    var releaseYear: String { get }
}

// MARK: - TVShowContent Protocol
// Protocol specific to TV Show content
protocol TVShowContent: MediaContent, BackdropImageLoadable {
    var numberOfSeasons: Int? { get }
    var numberOfEpisodes: Int? { get }
}

extension TVShowContent {
    var seasonsText: String {
        guard let count = numberOfSeasons else { return "" }
        return count == 1 ? "1 Season" : "\(count) Seasons"
    }
}

// MARK: - SeasonContent Protocol
// Protocol for season content
protocol SeasonContent: Identifiable, Codable {
    var id: Int { get }
    var name: String { get }
    var seasonNumber: Int { get }
    var posterURL: URL? { get }
}

// MARK: - EpisodeContent Protocol
// Protocol for episode content
protocol EpisodeContent: Identifiable, Codable, ThumbnailImageLoadable {
    var id: Int { get }
    var name: String { get }
    var episodeNumber: Int { get }
    var seasonNumber: Int { get }
    var overview: String? { get }
}

extension EpisodeContent {
    var formattedTitle: String {
        "E\(episodeNumber) - \(name)"
    }
}

// MARK: - Playable Protocol
// Protocol for content that can be played
protocol Playable {
    var playbackURL: URL? { get }
    var duration: Int? { get }
}

extension Playable {
    var formattedDuration: String? {
        guard let duration = duration else { return nil }
        let hours = duration / 60
        let minutes = duration % 60
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        }
        return "\(minutes)m"
    }
}
