import Foundation

public typealias CompletionHandler<T> = (Result<T, NetworkError>) -> Void

protocol BaseNetworkable {
  
  var requestDispatcher: NetworkRequestDispatcher { get }
  
  /// Make a GET request
  /// - Parameters:
  ///   - endpoint: Endpointable conforming object that contains endpoint specific information
  ///   - environment: Network / Development environment for request
  ///   - jwt: JWT to authorize request if needed
  ///   - parameters: Request query parameters to include in request if needed
  ///   - headers: Request headers to include in request if needed
  ///   - logger: `Logger` instance to log any applicable information gathered
  ///   - completion: Completion handler - returns `Result<Endpoint.Model, NetworkError>`
  func get<E: Endpointable>(
  endpoint: E,
  environment: Environment,
  jwt: JWT?,
  parameters: [URLQueryItem]?,
  headers: [HTTPHeader]?,
  logger: Logger,
  completion: @escaping CompletionHandler<E.Model>
  ) where E.Model: Getable
  
  /// Make a POST request
  /// - Parameters:
  ///   - endpoint: Endpointable conforming object that contains endpoint specific information
  ///   - body: POST request body
  ///   - environment: Network / Development environment for request
  ///   - jwt: JWT to authorize request if needed
  ///   - headers: Request headers to include in request
  ///   - referer: Referer to include in request headers if needed
  ///   - logger: Logger` instance to log any applicable information gathered
  ///   - completion: Completion handler - returns `Result<Endpoint.Model, NetworkError>`
  func post<E: Endpointable, U: Codable>(
    endpoint: E,
    body: U,
    environment: Environment,
    jwt: JWT?,
    headers: [HTTPHeader]?,
    referer: String?,
    logger: Logger,
    completion: @escaping CompletionHandler<E.Model>
  ) where E.Model: Postable
  
  /// Make a PUT request
  /// - Parameters:
  ///   - endpoint: Endpointable conforming object that contains endpoint specific information
  ///   - environment: Network / Development environment for request
  ///   - body: PUT request body
  ///   - jwt: JWT to authorize request if needed
  ///   - headers: Request headers to include in request
  ///   - referer: Referer to include in request headers if needed
  ///   - logger: Logger` instance to log any applicable information gathered
  ///   - completion: Completion handler - returns `Result<Endpoint.Model, NetworkError>`
  func put<E: Endpointable, U: Codable>(
    endpoint: E,
    environment: Environment,
    body: U,
    jwt: JWT?,
    headers: [HTTPHeader]?,
    referer: String?,
    logger: Logger,
    completion: @escaping CompletionHandler<E.Model>
  ) where E.Model: Putable
  
  /// Make a DELETE request
  /// - Parameters:
  ///   - endpoint: Endpointable conforming object that contains endpoint specific information
  ///   - environment: Network / Development environment for request
  ///   - jwt: JWT to authorize request if needed
  ///   - headers: Request headers to include in request
  ///   - referer: Referer to include in request headers if needed
  ///   - logger: Logger` instance to log any applicable information gathered
  ///   - completion: Completion handler - returns `Result<Void, NetworkError>`
  func delete<E: Endpointable>(
    endpoint: E,
    environment: Environment,
    jwt: JWT?,
    headers: [HTTPHeader]?,
    referer: String?,
    logger: Logger,
    completion: @escaping CompletionHandler<Void>
  ) where E.Model: Deleteable
}

