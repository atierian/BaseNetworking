import Foundation

struct BarService: Service {
  
  let base: BaseNetworkable
  
  /// Defines requests for Bar Service
  /// - Parameter base: Base networking object that requests for all services are routed through. Default value is `BaseNetworker`
  init(_ base: BaseNetworkable = BaseNetworker()) {
    self.base = base
  }
  
  /// Make a GET request to any of the Bar Service endpoints whose Model conforms to `Getable`
  ///
  /// - Important: Parameters passed into the `parameters` argument will discard any default parameters included in the `endpoint` object with duplicate names.
  /// - Parameters:
  ///   - endpoint: Endpoint defined by BarServiceEndpoint.
  ///   - environment: Network environment for request
  ///   - jwt: JWT to authorize request if needed. Default argument is `nil`
  ///   - parameters: Request parameters to include in request. Default argument is `nil`
  ///   - headers: Request headers to include in request. Default argument is `nil`
  ///   - logger: `Logger` instance to log any applicable information gathered.
  ///   - completion: Completion handler - returns `Result<Endpoint.Model, NetworkError>`
  func get<T: Codable & Getable>(
    _ endpoint: BarServiceEndpoint<T>,
    environment: Environment = .staging(),
    jwt: JWT? = nil,
    parameters: [URLQueryItem]? = nil,
    headers: [HTTPHeader]? = nil,
    logger: Logger = .error,
    completion: @escaping CompletionHandler<T>
  ) {
    logger.log(label: "Environment", value: environment.hostWithScheme, level: .debug)
    logger.log(label: "Path", value: endpoint.resource, level: .debug)
    logger.log(label: "Query Parameters", value: dump(parameters), level: .debug)
    logger.log(label: "Headers", value: dump(headers), level: .debug)
    logger.log(label: "JWT", value: jwt, level: .debug)
    
    base.get(endpoint: endpoint,
            environment: environment,
            jwt: jwt,
            parameters: parameters,
            headers: headers,
            logger: logger,
            completion: completion
    )
  }
  

  /// Make a GET request to any of the Bar Service endpoints whose Model conforms to `Getable`
  /// - Parameter serviceRequest: BarService.GetRequest object to configure request
  func get<T>(serviceRequest: GetRequest<T>) {
    get(
      serviceRequest.endpoint,
      environment: serviceRequest.environment,
      jwt: serviceRequest.jwt,
      parameters: serviceRequest.parameters,
      headers: serviceRequest.headers,
      logger: serviceRequest.logger,
      completion: serviceRequest.completion
    )
  }
}
