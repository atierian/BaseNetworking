import Foundation

struct FooService: Service {
  
  let base: BaseNetworkable
  
  /// Defines requests for Foo Service
  /// - Parameter base: Base networking object that requests for all services are routed through. Default value is `BaseNetworker`
  init(_ base: BaseNetworkable = BaseNetworker()) {
    self.base = base
  }
  
  /// Make a POST request to any of the Foo Service endpoints whose Model conforms to `Postable`
  /// - Parameters:
  ///   - endpoint: Endpoint defined by FooServiceEndpoint.
  ///   - body: POST request body
  ///   - environment: Network environment for request
  ///   - jwt: JWT to authorize request if needed. Default argument is `nil`
  ///   - referer: Referer to include in request headers if needed. Default argument is `nil`
  ///   - headers: Request headers to include in request. Default argument is `nil`
  ///   - logger: `Logger` instance to log any applicable information gathered.
  ///   - completion: Completion handler - returns `Result<Endpoint.Model, NetworkError>`
  func post<T: Codable & Postable>(
    _ endpoint: FooServiceEndpoint<T>,
    body: T,
    environment: Environment = .staging(),
    jwt: JWT? = nil,
    referer: String? = nil,
    headers: [HTTPHeader]? = nil,
    logger: Logger = .error,
    completion: @escaping CompletionHandler<T>
  ) {
    logger.log(label: "Environment", value: environment.hostWithScheme, level: .debug)
    logger.log(label: "Path", value: endpoint.resource, level: .debug)
    logger.log(label: "Body", value: body, level: .debug)
    logger.log(label: "Headers", value: dump(headers), level: .debug)
    logger.log(label: "JWT", value: jwt, level: .debug)
    
    base.post(
      endpoint: endpoint,
      body: body,
      environment: environment,
      jwt: jwt,
      headers: headers,
      referer: referer,
      logger: logger,
      completion: completion
    )
  }
  
  /// Make a POST request to any of the Foo Service endpoints whose Model conforms to `Postable`
  /// - Parameter serviceRequest: FooService.PostRequest object to configure request
  func post<T>(serviceRequest: PostRequest<T>) {
    post(
      serviceRequest.endpoint,
      body: serviceRequest.body,
      environment: serviceRequest.environment,
      jwt: serviceRequest.jwt,
      referer: serviceRequest.referer,
      headers: serviceRequest.headers,
      logger: serviceRequest.logger,
      completion: serviceRequest.completion
    )
  }
}

