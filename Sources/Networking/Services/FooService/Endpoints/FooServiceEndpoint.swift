import Foundation

/// Defines structure of all endpoints for `FooService`
struct FooServiceEndpoint<Model: Codable>: Endpointable {
  // Property documentation inherited by Endpointable protocol
  let resource: String
  var parameters: [URLQueryItem]?
  let headers: [HTTPHeader]?
  var response: (Data) throws -> Model
  
  let basePath = "/foo-service/v1"
  
  /// - Parameters:
  ///   - resource: Service endpoint. e.g. `/users`
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
