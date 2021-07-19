import Foundation

extension BarService {
  /// GET request configuration for Bar Service
  struct GetRequest<T: Codable & Getable> {
    /// Endpoint defined by BarServiceEndpoint.
    var endpoint: BarServiceEndpoint<T>
    
    /// Network environment for request
    var environment: Environment
    
    /// JWT to authorize request if needed. Default argument is `nil`
    var jwt: JWT?
    
    /// Request parameters to include in request. Default argument is `nil`
    var parameters: [URLQueryItem]?
    
    /// Request headers to include in request. Default argument is `nil`
    var headers: [HTTPHeader]?
    
    /// `Logger` instance to log any applicable information gathered.
    var logger: Logger
    
    /// Completion handler - returns `Result<Endpoint.Model, NetworkError>`
    var completion: CompletionHandler<T>
  }
}
