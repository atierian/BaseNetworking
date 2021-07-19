import Foundation

/// Representation of a network environment
public struct Environment {
  /// Host for this environment. e.g. `test.staging.com`
  public let host: String
  
  public init(host: String) {
    self.host = host
  }
  
  /// Host including `https` scheme
  public var hostWithScheme: String {
    "https://" + host
  }
}

// MARK: TargetSubdomain definition
extension Environment {
  /// Representation of subdomain for environment
  public enum TargetSubdomain: String {
    case user
    case staff
  }
}

// MARK: Equatable conformance
extension Environment: Equatable {
  /// Equatable conformance decided by `host` property
  /// - Parameters:
  ///   - lhs: Environment
  ///   - rhs: Environment
  /// - Returns: `true` if `host` properties are equal. `false` if not.
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.host == rhs.host
  }
}


