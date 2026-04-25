//
//  TestDemoTests.swift
//  TestDemoTests
//
//  Created by Apple on 23/04/2026.
//

import Testing
import Foundation
@testable import TestDemo

// MARK: - TVShow Model Tests
struct TVShowModelTests {
    
    @Test func testTVShowDecoding() throws {
        let json = """
        {
            "id": 62852,
            "name": "Supergirl",
            "overview": "A test overview",
            "poster_path": "/poster.jpg",
            "backdrop_path": "/backdrop.jpg",
            "first_air_date": "2015-10-26",
            "vote_average": 7.5,
            "number_of_seasons": 6,
            "number_of_episodes": 126
        }
        """.data(using: .utf8)!
        
        let tvShow = try JSONDecoder().decode(TVShow.self, from: json)
        
        #expect(tvShow.id == 62852)
        #expect(tvShow.name == "Supergirl")
        #expect(tvShow.overview == "A test overview")
        #expect(tvShow.title == "Supergirl")
        #expect(tvShow.rating == 7.5)
        #expect(tvShow.numberOfSeasons == 6)
        #expect(tvShow.numberOfEpisodes == 126)
    }
    
    @Test func testTVShowReleaseYear() throws {
        let json = """
        {
            "id": 1,
            "name": "Test Show",
            "first_air_date": "2015-10-26"
        }
        """.data(using: .utf8)!
        
        let tvShow = try JSONDecoder().decode(TVShow.self, from: json)
        
        #expect(tvShow.releaseYear == "2015")
        #expect(tvShow.year == "2015")
    }
    
    @Test func testTVShowReleaseYearWithNilDate() throws {
        let json = """
        {
            "id": 1,
            "name": "Test Show"
        }
        """.data(using: .utf8)!
        
        let tvShow = try JSONDecoder().decode(TVShow.self, from: json)
        
        #expect(tvShow.releaseYear == "")
    }
    
    @Test func testTVShowBackdropURL() throws {
        let json = """
        {
            "id": 1,
            "name": "Test Show",
            "backdrop_path": "/test.jpg"
        }
        """.data(using: .utf8)!
        
        let tvShow = try JSONDecoder().decode(TVShow.self, from: json)
        
        #expect(tvShow.backdropURL?.absoluteString == "https://image.tmdb.org/t/p/original/test.jpg")
    }
    
    @Test func testTVShowPosterURL() throws {
        let json = """
        {
            "id": 1,
            "name": "Test Show",
            "poster_path": "/poster.jpg"
        }
        """.data(using: .utf8)!
        
        let tvShow = try JSONDecoder().decode(TVShow.self, from: json)
        
        #expect(tvShow.posterURL?.absoluteString == "https://image.tmdb.org/t/p/w500/poster.jpg")
    }
    
    @Test func testTVShowNilURLsWhenPathMissing() throws {
        let json = """
        {
            "id": 1,
            "name": "Test Show"
        }
        """.data(using: .utf8)!
        
        let tvShow = try JSONDecoder().decode(TVShow.self, from: json)
        
        #expect(tvShow.backdropURL == nil)
        #expect(tvShow.posterURL == nil)
    }
}

// MARK: - Season Model Tests
struct SeasonModelTests {
    
    @Test func testSeasonDecoding() throws {
        let json = """
        {
            "id": 123,
            "name": "Season 1",
            "overview": "First season",
            "season_number": 1,
            "episode_count": 20,
            "air_date": "2015-10-26",
            "poster_path": "/season1.jpg"
        }
        """.data(using: .utf8)!
        
        let season = try JSONDecoder().decode(Season.self, from: json)
        
        #expect(season.id == 123)
        #expect(season.name == "Season 1")
        #expect(season.overview == "First season")
        #expect(season.seasonNumber == 1)
        #expect(season.episodeCount == 20)
    }
    
    @Test func testSeasonPosterURL() throws {
        let json = """
        {
            "id": 123,
            "name": "Season 1",
            "season_number": 1,
            "poster_path": "/season1.jpg"
        }
        """.data(using: .utf8)!
        
        let season = try JSONDecoder().decode(Season.self, from: json)
        
        #expect(season.posterURL?.absoluteString == "https://image.tmdb.org/t/p/w300/season1.jpg")
    }
}

// MARK: - Episode Model Tests
struct EpisodeModelTests {
    
    @Test func testEpisodeDecoding() throws {
        let json = """
        {
            "id": 456,
            "name": "Pilot",
            "overview": "First episode",
            "still_path": "/still.jpg",
            "episode_number": 1,
            "season_number": 1,
            "air_date": "2015-10-26",
            "vote_average": 8.0,
            "runtime": 42
        }
        """.data(using: .utf8)!
        
        let episode = try JSONDecoder().decode(Episode.self, from: json)
        
        #expect(episode.id == 456)
        #expect(episode.name == "Pilot")
        #expect(episode.overview == "First episode")
        #expect(episode.episodeNumber == 1)
        #expect(episode.seasonNumber == 1)
        #expect(episode.runtime == 42)
    }
    
    @Test func testEpisodeThumbnailURL() throws {
        let json = """
        {
            "id": 456,
            "name": "Pilot",
            "episode_number": 1,
            "season_number": 1,
            "still_path": "/still.jpg"
        }
        """.data(using: .utf8)!
        
        let episode = try JSONDecoder().decode(Episode.self, from: json)
        
        #expect(episode.thumbnailURL?.absoluteString == "https://image.tmdb.org/t/p/w300/still.jpg")
        #expect(episode.stillURL?.absoluteString == "https://image.tmdb.org/t/p/w300/still.jpg")
    }
    
    @Test func testEpisodeDuration() throws {
        let json = """
        {
            "id": 456,
            "name": "Pilot",
            "episode_number": 1,
            "season_number": 1,
            "runtime": 42
        }
        """.data(using: .utf8)!
        
        let episode = try JSONDecoder().decode(Episode.self, from: json)
        
        #expect(episode.duration == 42)
    }
    
    @Test func testEpisodeFormattedTitle() throws {
        let json = """
        {
            "id": 456,
            "name": "Pilot",
            "episode_number": 1,
            "season_number": 1
        }
        """.data(using: .utf8)!
        
        let episode = try JSONDecoder().decode(Episode.self, from: json)
        
        #expect(episode.formattedTitle == "E1 - Pilot")
    }
}

// MARK: - Genre Model Tests
struct GenreModelTests {
    
    @Test func testGenreDecoding() throws {
        let json = """
        {
            "id": 10765,
            "name": "Sci-Fi & Fantasy"
        }
        """.data(using: .utf8)!
        
        let genre = try JSONDecoder().decode(Genre.self, from: json)
        
        #expect(genre.id == 10765)
        #expect(genre.name == "Sci-Fi & Fantasy")
    }
}

// MARK: - API Configuration Tests
struct APIConfigurationTests {
    
    @Test func testDefaultConfiguration() {
        let config = APIConfiguration()
        
        #expect(config.baseURL == "https://api.themoviedb.org/3")
        #expect(config.apiKey == "ecef14eac236a5d4ec6ac3a4a4761e8f")
        #expect(config.imageBaseURL == "https://image.tmdb.org/t/p")
        #expect(config.defaultTVShowId == 62852)
    }
    
    @Test func testCustomConfiguration() {
        let config = APIConfiguration(
            baseURL: "https://custom.api.com",
            apiKey: "customkey",
            imageBaseURL: "https://custom.images.com",
            sampleVideoURL: "https://custom.video.mp4",
            defaultTVShowId: 12345
        )
        
        #expect(config.baseURL == "https://custom.api.com")
        #expect(config.apiKey == "customkey")
        #expect(config.imageBaseURL == "https://custom.images.com")
        #expect(config.defaultTVShowId == 12345)
    }
}

// MARK: - API Endpoint Tests
struct APIEndpointTests {
    
    @Test func testTVShowDetailsPath() {
        let endpoint = APIEndpoint.tvShowDetails(id: 62852)
        
        #expect(endpoint.path == "/tv/62852")
    }
    
    @Test func testSeasonDetailsPath() {
        let endpoint = APIEndpoint.seasonDetails(tvShowId: 62852, seasonNumber: 1)
        
        #expect(endpoint.path == "/tv/62852/season/1")
    }
    
    @Test func testEpisodeDetailsPath() {
        let endpoint = APIEndpoint.episodeDetails(tvShowId: 62852, seasonNumber: 1, episodeNumber: 5)
        
        #expect(endpoint.path == "/tv/62852/season/1/episode/5")
    }
    
    @Test func testEndpointURL() {
        let config = APIConfiguration()
        let endpoint = APIEndpoint.tvShowDetails(id: 62852)
        
        let url = endpoint.url(with: config)
        
        #expect(url != nil)
        #expect(url?.absoluteString.contains("api.themoviedb.org") == true)
        #expect(url?.absoluteString.contains("api_key=") == true)
        #expect(url?.absoluteString.contains("/tv/62852") == true)
    }
}

// MARK: - Network Error Tests
struct NetworkErrorTests {
    
    @Test func testNetworkErrorDescriptions() {
        let invalidURL = NetworkError.invalidURL
        let invalidResponse = NetworkError.invalidResponse
        let serverError = NetworkError.serverError(500)
        let decodingError = NetworkError.decodingError(NSError(domain: "test", code: 1))
        
        #expect(invalidURL.localizedDescription.isEmpty == false)
        #expect(invalidResponse.localizedDescription.isEmpty == false)
        #expect(serverError.localizedDescription.isEmpty == false)
        #expect(decodingError.localizedDescription.isEmpty == false)
    }
}

// MARK: - Dependency Container Tests
struct DependencyContainerTests {
    
    @Test func testContainerInitialization() {
        let container = DependencyContainer()
        
        #expect(container.configuration.defaultTVShowId == 62852)
    }
    
    @Test func testContainerWithCustomConfiguration() {
        let customConfig = APIConfiguration(defaultTVShowId: 12345)
        let container = DependencyContainer(configuration: customConfig)
        
        #expect(container.configuration.defaultTVShowId == 12345)
    }
    
    @Test func testNetworkServiceCreation() {
        let container = DependencyContainer()
        let networkService = container.networkService
        
        #expect(networkService.configuration.baseURL == "https://api.themoviedb.org/3")
    }
    
    @Test func testRepositoryCreation() {
        let container = DependencyContainer()
        let repository = container.tvShowRepository
        
        #expect(repository != nil)
    }
    
    @Test func testViewModelFactoryCreation() {
        let container = DependencyContainer()
        let viewModel = container.makeTVShowDetailViewModel(tvShowId: 100)
        
        #expect(viewModel != nil)
    }
    
    @Test func testVideoPlayerViewModelFactory() {
        let container = DependencyContainer()
        let viewModel = container.makeVideoPlayerViewModel(urlString: "https://test.mp4")
        
        #expect(viewModel != nil)
    }
    
    @Test func testVideoPlayerViewModelDefaultURL() {
        let container = DependencyContainer()
        let viewModel = container.makeVideoPlayerViewModel()
        
        #expect(viewModel != nil)
    }
}

// MARK: - App Environment Tests
struct AppEnvironmentTests {
    
    @Test func testAppEnvironmentInitialization() {
        let environment = AppEnvironment()
        
        #expect(environment.container.configuration.defaultTVShowId == 62852)
    }
    
    @Test func testAppEnvironmentWithCustomContainer() {
        let customConfig = APIConfiguration(defaultTVShowId: 99999)
        let customContainer = DependencyContainer(configuration: customConfig)
        let environment = AppEnvironment(container: customContainer)
        
        #expect(environment.container.configuration.defaultTVShowId == 99999)
    }
}

// MARK: - Mock Network Service for Repository Tests
final class MockNetworkService: NetworkServiceProtocol, @unchecked Sendable {
    let configuration: APIConfigurationProtocol = APIConfiguration()
    var mockTVShow: TVShow?
    var mockSeason: Season?
    var shouldThrowError = false
    
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        if shouldThrowError {
            throw NetworkError.serverError(500)
        }
        
        switch endpoint {
        case .tvShowDetails:
            if let tvShow = mockTVShow as? T {
                return tvShow
            }
        case .seasonDetails:
            if let season = mockSeason as? T {
                return season
            }
        case .episodeDetails:
            break
        }
        
        throw NetworkError.invalidResponse
    }
}

// MARK: - Repository Tests
struct TVShowRepositoryTests {
    
    @Test func testRepositoryCreation() {
        let mockService = MockNetworkService()
        let repository = TVShowRepository(networkService: mockService)
        
        #expect(repository != nil)
    }
}
