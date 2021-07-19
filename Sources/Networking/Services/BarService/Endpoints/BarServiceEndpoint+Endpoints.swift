import Foundation

// MARK: BarServiceEndpoints Defined
extension BarServiceEndpoint {
  /// Endpoint for getting `BarUser`
  static var users: BarServiceEndpoint<BarUser> {
    .init(resource: "/users")
  }
  
  /// Creates a `BarServiceEndpoint` that contains information to make request to `/place` endpoint
  /// - Parameter searchText: Text to include in the value of the `search` parameter of the request that returns a `BarPlace`
  /// - Returns: `BarServiceEndpoint<BarUser>` that contains information to make request to `/place` endpoint
  static func places(searchText: String) -> BarServiceEndpoint<BarPlace> {
    .init(
      resource: "/places",
      varArgParameters:
        URLQueryItem(name: "search", value: searchText),
        URLQueryItem(name: "systemID", value: "42")
    )
  }
}
