import Foundation

// MARK: - APIConfigurationProtocol
protocol APIConfigurationProtocol {
    var baseURL: String { get }
    var apiKey: String { get }
    var imageBaseURL: String { get }
    var sampleVideoURL: String { get }
    var defaultTVShowId: Int { get }
}

// MARK: - Default API Configuration
struct APIConfiguration: APIConfigurationProtocol {
    let baseURL: String
    let apiKey: String
    let imageBaseURL: String
    let sampleVideoURL: String
    let defaultTVShowId: Int
    
    init(
        baseURL: String = "https://api.themoviedb.org/3",
        apiKey: String = "ecef14eac236a5d4ec6ac3a4a4761e8f",
        imageBaseURL: String = "https://image.tmdb.org/t/p",
        sampleVideoURL: String = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        defaultTVShowId: Int = 62852
    ) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.imageBaseURL = imageBaseURL
        self.sampleVideoURL = sampleVideoURL
        self.defaultTVShowId = defaultTVShowId
    }
}
