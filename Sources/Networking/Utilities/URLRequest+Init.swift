import Foundation

extension URLRequest {
  /// Create a `URLRequest` to give to `NetworkRequestDispatcher`
  /// - Parameters:
  ///   - url: `URL` for request
  ///   - endpoint: `Endpointable` conforming object
  ///   - headers: Request headers
  ///   - method: `HTTPMethod`
  ///   - jwt: `JWT` to authorize request
  ///   - referer: Value for `Referer` header if needed. Default argument is `nil`
  public init<E: Endpointable>(
    url: URL,
    endpoint: E,
    headers: [HTTPHeader]?,
    method: HTTPMethod,
    jwt: JWT?,
    referer: String? = nil)
  {
    self.init(url: url)
    httpMethod = method.rawValue
    addValue("application/json", forHTTPHeaderField: "Content-Type")
    addHeaders(endpoint.headers)
    setHeaders(headers)
    referer.flatMap { setValue($0, forHTTPHeaderField: "Referer") }
    jwt.flatMap { setValue($0.headerValue, forHTTPHeaderField: $0.headerKey) }
  }
  
  /// Add `[HTTPHeader]?` to `URLRequest` headers
  /// - Parameter headers: Request headers
  /// - Important: This adds headers and does **NOT** override existing header values
  private mutating func addHeaders(_ headers: [HTTPHeader]?) {
    headers?.forEach {
      addValue($0.value, forHTTPHeaderField: $0.key)
    }
  }
  
  /// Set `[HTTPHeader]?` to `URLRequest` headers
  /// - Parameter headers: Request headers
  /// - Important: This sets headers and **DOES** override existing header values
  private mutating func setHeaders(_ headers: [HTTPHeader]?) {
    headers?.forEach {
      setValue($0.value, forHTTPHeaderField: $0.key)
    }
  }
}
