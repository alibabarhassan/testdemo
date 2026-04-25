import Foundation

// MARK: - NetworkService Implementation
final class NetworkService: NetworkServiceProtocol, @unchecked Sendable {
    
    // MARK: - Properties
    let configuration: APIConfigurationProtocol
    private let session: URLSessionProtocol
    private let decoder: JSONDecoder
    
    // MARK: - Initialization
    init(
        configuration: APIConfigurationProtocol = APIConfiguration(),
        session: URLSessionProtocol = URLSession.shared
    ) {
        self.configuration = configuration
        self.session = session
        self.decoder = JSONDecoder()
    }
    
    // MARK: - NetworkServiceProtocol
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        guard let url = endpoint.url(with: configuration) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
