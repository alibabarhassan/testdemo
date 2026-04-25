import Foundation

// MARK: - TVShow Model
struct TVShow: TVShowContent {
    let id: Int
    let name: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String?
    let voteAverage: Double?
    let numberOfSeasons: Int?
    let numberOfEpisodes: Int?
    let genres: [Genre]?
    let seasons: [Season]?
    let status: String?
    let tagline: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview, genres, seasons, status, tagline
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
    }
    
    // MARK: - MediaContent Protocol
    var title: String { name }
    var rating: Double? { voteAverage }
    var releaseYear: String {
        guard let date = firstAirDate, date.count >= 4 else { return "" }
        return String(date.prefix(4))
    }
    
    // MARK: - BackdropImageLoadable Protocol
    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(path)")
    }
    
    // MARK: - Computed Properties
    var year: String { releaseYear }
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}

// MARK: - Genre Model
struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}
