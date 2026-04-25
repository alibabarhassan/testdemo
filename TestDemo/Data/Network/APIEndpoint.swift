import Foundation

// MARK: - APIEndpoint
enum APIEndpoint {
    case tvShowDetails(id: Int)
    case seasonDetails(tvShowId: Int, seasonNumber: Int)
    case episodeDetails(tvShowId: Int, seasonNumber: Int, episodeNumber: Int)
    
    var path: String {
        switch self {
        case .tvShowDetails(let id):
            return "/tv/\(id)"
        case .seasonDetails(let tvShowId, let seasonNumber):
            return "/tv/\(tvShowId)/season/\(seasonNumber)"
        case .episodeDetails(let tvShowId, let seasonNumber, let episodeNumber):
            return "/tv/\(tvShowId)/season/\(seasonNumber)/episode/\(episodeNumber)"
        }
    }
    
    func url(with configuration: APIConfigurationProtocol) -> URL? {
        var components = URLComponents(string: configuration.baseURL + path)
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: configuration.apiKey)
        ]
        return components?.url
    }
}
