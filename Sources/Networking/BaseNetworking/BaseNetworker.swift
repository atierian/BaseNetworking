import Foundation

public struct BaseNetworker: BaseNetworkable {
  
  /// Handles dispatching network requests
  let requestDispatcher: NetworkRequestDispatcher
  
  init(_ requestDispatcher: NetworkRequestDispatcher = NetworkRequestDispatcher()) {
    self.requestDispatcher = requestDispatcher
  }
  
  // Documentation provided by NetworkRequestDispatchable protocol
  func get<E: Endpointable>(
    endpoint: E,
    environment: Environment,
    jwt: JWT?,
    parameters: [URLQueryItem]?,
    headers: [HTTPHeader]?,
    logger: Logger = .warning,
    completion: @escaping CompletionHandler<E.Model>
  ) where E.Model: Getable {
    
    let urlComponents = URLComponents(endpoint: endpoint, environment: environment, parameters: parameters)
    logger.log(label: "URL Components", value: dump(urlComponents), level: .debug)
    
    guard let url = urlComponents.url else {
      logger.log(label: "URL Components for invalid URL", value: dump(urlComponents), level: .error)
      completion(.failure(.badURL))
      return
    }
    
    let request = URLRequest(url: url, endpoint: endpoint, headers: headers, method: .get, jwt: jwt)
    logger.log(label: "URL Request", value: dump(request), level: .debug)
    logger.log(label: "URL Request Headers", value: dump(request.allHTTPHeaderFields), level: .debug)
    
    requestDispatcher.get(request: request, logger: logger) { result in
      handleResponseCompletion(result, endpoint: endpoint, logger: logger, completion: completion)
    }
  }
  
  // Documentation provided by NetworkRequestDispatchable protocol
  func post<E: Endpointable, U: Codable>(
    endpoint: E,
    body: U,
    environment: Environment,
    jwt: JWT?,
    headers: [HTTPHeader]?,
    referer: String?,
    logger: Logger = .warning,
    completion: @escaping CompletionHandler<E.Model>
  ) where E.Model: Postable {
    
    let urlComponents = URLComponents(endpoint: endpoint, environment: environment)
    logger.log(label: "URL Components", value: dump(urlComponents), level: .debug)
    
    guard let url = urlComponents.url else {
      logger.log(label: "URL Components for invalid URL", value: dump(urlComponents), level: .error)
      completion(.failure(.badURL))
      return
    }
    
    guard let data = encode(body: body, logger: logger) else {
      completion(.failure(.unencodableBody))
      return
    }
    
    let request = URLRequest(url: url, endpoint: endpoint, headers: headers, method: .post, jwt: jwt, referer: referer)
    logger.log(label: "URL Request", value: dump(request), level: .debug)
    
    requestDispatcher.post(request: request, body: data, logger: logger) { result in
      handleResponseCompletion(result, endpoint: endpoint, logger: logger, completion: completion)
    }
  }
  
  // Documentation provided by NetworkRequestDispatchable protocol
  func put<E: Endpointable, U: Codable>(
    endpoint: E,
    environment: Environment,
    body: U,
    jwt: JWT?,
    headers: [HTTPHeader]?,
    referer: String?,
    logger: Logger = .warning,
    completion: @escaping CompletionHandler<E.Model>
  ) where E.Model: Putable {
    
    let urlComponents = URLComponents(endpoint: endpoint, environment: environment)
    logger.log(label: "URL Components", value: dump(urlComponents), level: .debug)
    
    guard let url = urlComponents.url else {
      logger.log(label: "URL Components for invalid URL", value: dump(urlComponents), level: .error)
      completion(.failure(.badURL))
      return
    }
    
    guard let data = encode(body: body, logger: logger) else {
      completion(.failure(.unencodableBody))
      return
    }
    
    let request = URLRequest(url: url, endpoint: endpoint, headers: headers, method: .post, jwt: jwt, referer: referer)
    logger.log(label: "URL Request", value: dump(request), level: .debug)
    
    requestDispatcher.put(request: request, body: data, logger: logger) { result in
      handleResponseCompletion(result, endpoint: endpoint, logger: logger, completion: completion)
    }
  }
  
  // Documentation provided by NetworkRequestDispatchable protocol
  func delete<E: Endpointable>(
    endpoint: E,
    environment: Environment,
    jwt: JWT?,
    headers: [HTTPHeader]?,
    referer: String?,
    logger: Logger = .warning,
    completion: @escaping CompletionHandler<Void>
  ) where E.Model: Deleteable {
    
    let urlComponents = URLComponents(endpoint: endpoint, environment: environment)
    logger.log(label: "URL Components", value: dump(urlComponents), level: .debug)
    
    guard let url = urlComponents.url else {
      logger.log(label: "URL Components for invalid URL", value: dump(urlComponents), level: .error)
      completion(.failure(.badURL))
      return
    }
    
    let request = URLRequest(url: url, endpoint: endpoint, headers: headers, method: .delete, jwt: jwt, referer: referer)
    logger.log(label: "URL Request", value: dump(request), level: .debug)
    requestDispatcher.delete(request: request, logger: logger, completion: completion)
  }
  
  
  /// Complete request with decoding data or error from `Result`
  /// - Parameters:
  ///   - result: Result generated from request response
  ///   - endpoint: Endpoint received during request
  ///   - logger: `Logger` instance received in request
  ///   - completion: Completion handler received in request
  private func handleResponseCompletion<E: Endpointable>(
    _ result: Result<Data, NetworkError>,
    endpoint: E,
    logger: Logger,
    completion: @escaping CompletionHandler<E.Model>
  ) {
    completion(Deserializing.baseNetworkResult.deserialize((result, endpoint.response, logger)))
  }
  
  /// Encode body object
  /// - Parameters:
  ///   - body: Encodable conforming object to be including in request
  ///   - logger: `Logger` instance received in request
  /// - Returns: `Data` if encoding succeeded. `nil` if not
  private func encode<T: Encodable>(body: T, logger: Logger) -> Data? {
    Serializing.json.serialize((body, logger, JSONEncoder()))
  }
}
