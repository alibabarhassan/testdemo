import Foundation

// MARK: - ViewModelFactoryProtocol
// Factory protocol for creating view models with proper dependency injection
protocol ViewModelFactoryProtocol {
    associatedtype ViewModel
    associatedtype Dependencies
    
    func make(with dependencies: Dependencies) -> ViewModel
}

// MARK: - TVShowDetailViewModelFactory
protocol TVShowDetailViewModelFactoryProtocol {
    func makeTVShowDetailViewModel(tvShowId: Int) -> TVShowDetailViewModel
}

// MARK: - VideoPlayerViewModelFactory
protocol VideoPlayerViewModelFactoryProtocol {
    func makeVideoPlayerViewModel(urlString: String) -> VideoPlayerViewModel
}

// MARK: - Combined ViewModel Factory
protocol AppViewModelFactoryProtocol: TVShowDetailViewModelFactoryProtocol, VideoPlayerViewModelFactoryProtocol {}
