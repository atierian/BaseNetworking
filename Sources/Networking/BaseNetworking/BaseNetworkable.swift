import Foundation

public typealias CompletionHandler<T> = (Result<T, NetworkError>) -> Void

protocol BaseNetworkable {
  
  var requestDispatcher: NetworkRequestDispatcher { get }
  
  func get<E: Endpointable>(
  endpoint: E,
  environment: Environment,
  jwt: JWT?,
  parameters: [URLQueryItem]?,
  headers: [HTTPHeader]?,
  logger: Logger,
  completion: @escaping CompletionHandler<E.Model>
  ) where E.Model: Getable
  
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

