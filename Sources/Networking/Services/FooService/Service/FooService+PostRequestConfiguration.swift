import Foundation

extension FooService {
  
  /// POST request configuration for Foo Service
  struct PostRequest<T: Codable & Postable> {
    /// Endpoint defined by FooServiceEndpoint.
    var endpoint: FooServiceEndpoint<T>
    
    /// POST request body
    var body: T
    
    /// Network environment for request
    var environment: Environment
    
    /// JWT to authorize request if needed. Default value is `nil`
    var jwt: JWT? = nil
    
    /// Referer to include in request headers if needed. Default value is `nil`
    var referer: String? = nil
    
    /// Request headers to include in request. Default value is `nil`
    var headers: [HTTPHeader]? = nil
    
    ///`Logger` instance to log any applicable information gathered.
    var logger: Logger
    
    /// Completion handler - returns `Result<Endpoint.Model, NetworkError>`
    var completion: CompletionHandler<T>
  }
}
