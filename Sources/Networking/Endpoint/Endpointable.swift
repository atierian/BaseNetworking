import Foundation

public protocol Endpointable {
  associatedtype Model: Codable
  
  /// Response handler to decode `Data` into `Model`
  var response: (Data) throws -> Model { get }
  /// Service endpoint. e.g. `/user`
  var resource: String { get }
  /// Default headers to be included in every request for this `Endpoint`
  var headers: [HTTPHeader]? { get }
  /// Default parameters to be included in every request for this `Endpoint`
  var parameters: [URLQueryItem]? { get }
}

