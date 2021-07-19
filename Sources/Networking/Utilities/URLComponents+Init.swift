import Foundation

extension URLComponents {
  /// Create an instance of`URLComponents`
  /// - Parameters:
  ///   - scheme: `URLComponents` scheme property. Default agument is `"https"`
  ///   - endpoint: `Endpointable` conforming object
  ///   - environment: Environment for request
  public init<E: Endpointable>(scheme: String = "https", endpoint: E, environment: Environment) {
    self.init()
    self.scheme = scheme
    host = environment.host
    path = endpoint.resource
  }
  
  /// Create an instance of`URLComponents` for a `GET` request.
  ///
  /// ~~~
  /// let components = URLComponents(
  ///   endpoint: exampleEndpoint,
  ///   environment: .staging(),
  ///   parameters: queryItems
  ///   )
  /// ~~~
  /// - Parameters:
  ///   - scheme: `URLComponents` scheme property. Default agument is `"https"`
  ///   - endpoint: `Endpointable` conforming object
  ///   - environment: Environment for request
  ///   - parameters: Request parameters to be included in `URL`.
  /// - Important: Parameters passed into the `parameters` argument will discard any default parameters included in the `endpoint` object with duplicate names.
  public init<E: Endpointable>(
    scheme: String = "https",
    endpoint: E,
    environment: Environment,
    parameters: [URLQueryItem]?
  ) where E.Model: Getable {
    self.init()
    self.scheme = scheme
    host = environment.host
    path = endpoint.resource
    queryItems = unionByParameterKey(primary: parameters, other: endpoint.parameters)
  }
  
  /// Create a new Array of `URLQueryItem` from two Arrays. If there are any duplicate `name` properties, the members from `primary` will be kept - the members from `other` will be discarded
  /// - Parameters:
  ///   - primary: `URLQueryItem`s to be **kept** in the case of matching `name` properties
  ///   - other: `URLQueryItem`s to be **discarded** in the case of matching `name` properties
  /// - Returns: Combined Array of `[URLQueryItem]?` with no duplicate `name` properties
  private func unionByParameterKey(primary: [URLQueryItem]?, other: [URLQueryItem]?) -> [URLQueryItem]? {
    guard let primary = primary else { return other }
    guard let other = other else { return primary }
    
    var paramDict = other.reduce(into: [String: String?](), {
      $0[$1.name] = $1.value
    })
    
    primary.forEach {
      paramDict[$0.name] = $0.value
    }
    
    return paramDict.map(URLQueryItem.init)
  }
}
