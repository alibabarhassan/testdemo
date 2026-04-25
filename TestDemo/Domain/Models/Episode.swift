import Foundation

// MARK: - Episode Model
struct Episode: EpisodeContent, Playable {
    let id: Int
    let name: String
    let overview: String?
    let stillPath: String?
    let episodeNumber: Int
    let seasonNumber: Int
    let airDate: String?
    let voteAverage: Double?
    let runtime: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview, runtime
        case stillPath = "still_path"
        case episodeNumber = "episode_number"
        case seasonNumber = "season_number"
        case airDate = "air_date"
        case voteAverage = "vote_average"
    }
    
    // MARK: - ThumbnailImageLoadable Protocol
    var thumbnailURL: URL? {
        guard let path = stillPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w300\(path)")
    }
    
    var stillURL: URL? { thumbnailURL }
    
    // MARK: - Playable Protocol
    var playbackURL: URL? { nil }
    var duration: Int? { runtime }
}
