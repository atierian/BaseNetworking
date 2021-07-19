import Foundation

/// Defines structure of all endpoints for `BarService`
public struct BarServiceEndpoint<Model: Codable>: Endpointable {
  // Property documentation inherited by Endpointable protocol
  public let resource: String
  public let parameters: [URLQueryItem]?
  public let headers: [HTTPHeader]?
  public let response: (Data) throws -> Model
  public let basePath = "/bar/v1"
  
  /// - Parameters:
  ///   - resource: Service endpoint. e.g. `/user`
  ///   - parameters: Default parameters to be included in every request for this `Endpoint`
  ///   - headers: Default headers to be included in every request for this `Endpoint`
  internal init(
    resource: String,
    parameters: [URLQueryItem]? = nil,
    headers: [HTTPHeader]? = nil
  ) {
    self.resource = basePath + resource
    self.parameters = parameters
    self.headers = headers
    self.response = { try JSONDecoder().decode(Model.self, from: $0) }
  }
}

// MARK: VarArg Initializer
extension BarServiceEndpoint {
  /// Initializer with `varArgParameters` for convenience
  /// - Parameters:
  ///   - resource: Service endpoint. e.g. `/user`
  ///   - varArgParameters: Default parameters to be included in every request for this `Endpoint`
  ///   - headers: Default headers to be included in every request for this `Endpoint`
  internal init(
    resource: String,
    varArgParameters: URLQueryItem...,
    headers: [HTTPHeader]? = nil
  ) {
    self.init(resource: resource, parameters: varArgParameters, headers: headers)
  }
}
  
