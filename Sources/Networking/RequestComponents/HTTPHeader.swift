import Foundation

/// Representation of HTTP header included in network request
public struct HTTPHeader {
  /// Header key
  public let key: String
  /// Header value
  public let value: String
  
  /// Creates a new `HTTPHeader`
  /// - Parameters:
  ///   - key: Header key
  ///   - value: Header value
  public init(key: String, value: String) {
    self.key = key
    self.value = value
  }
}
