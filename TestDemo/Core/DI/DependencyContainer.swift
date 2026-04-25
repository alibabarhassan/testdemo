import Foundation
import Combine

// MARK: - DependencyContainerProtocol
protocol DependencyContainerProtocol: AppViewModelFactoryProtocol {
    var configuration: APIConfigurationProtocol { get }
    var networkService: NetworkServiceProtocol { get }
    var tvShowRepository: TVShowRepositoryProtocol { get }
}

// MARK: - DependencyContainer
final class DependencyContainer: DependencyContainerProtocol {
    
    // MARK: - Configuration
    let configuration: APIConfigurationProtocol
    
    // MARK: - Initialization
    init(configuration: APIConfigurationProtocol = APIConfiguration()) {
        self.configuration = configuration
    }
    
    // MARK: - Network Layer
    private(set) lazy var networkService: NetworkServiceProtocol = {
        NetworkService(configuration: configuration, session: URLSession.shared)
    }()
    
    // MARK: - Repository Layer
    private(set) lazy var tvShowRepository: TVShowRepositoryProtocol = {
        TVShowRepository(networkService: networkService)
    }()
    
    // MARK: - ViewModel Factories
    func makeTVShowDetailViewModel(tvShowId: Int = 62852) -> TVShowDetailViewModel {
        TVShowDetailViewModel(tvShowId: tvShowId, repository: tvShowRepository)
    }
    
    func makeVideoPlayerViewModel(urlString: String) -> VideoPlayerViewModel {
        VideoPlayerViewModel(urlString: urlString)
    }
    
    func makeVideoPlayerViewModel() -> VideoPlayerViewModel {
        VideoPlayerViewModel(urlString: configuration.sampleVideoURL)
    }
}

// MARK: - App Environment
final class AppEnvironment: ObservableObject {
    let container: DependencyContainer
    
    init(container: DependencyContainer = DependencyContainer()) {
        self.container = container
    }
}
