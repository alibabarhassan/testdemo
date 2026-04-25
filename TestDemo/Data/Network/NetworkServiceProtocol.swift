import Foundation

// MARK: - NetworkServiceProtocol
// Protocol for network service implementations
protocol NetworkServiceProtocol: Sendable {
    var configuration: APIConfigurationProtocol { get }
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T
}

// MARK: - URLSessionProtocol
// Protocol for URL session abstraction (useful for testing)
protocol URLSessionProtocol: Sendable {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

// MARK: - CacheableNetworkService Protocol
// Protocol for network services with caching capabilities
protocol CacheableNetworkServiceProtocol: NetworkServiceProtocol {
    var cachePolicy: CachePolicy { get }
    func clearCache()
}

// MARK: - Cache Policy
enum CachePolicy {
    case none
    case memory(duration: TimeInterval)
    case disk(duration: TimeInterval)
    case memoryAndDisk(memoryDuration: TimeInterval, diskDuration: TimeInterval)
}
