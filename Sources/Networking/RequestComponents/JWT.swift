import Foundation

/// Representation of a JSON Web Token used to authorize requests
public struct JWT {
  
  /// The JWT value
  let value: String
  
  /// Header value to be included in request
  let headerValue: String
  
  /// Header key to be included in request
  let headerKey: String
    
  /// Creates a new `JWT` with `headerValue` and `headerKey` for an **encrypted** JSON Web Token
  /// - Parameter jwt: JSON Web Token to authorize request
  /// - Returns: `JWT`
  static func encrypted(_ jwt: String) -> JWT {
    .init(value: jwt, headerValue: "encryptedJWT=\(jwt)", headerKey: "Cookie")
  }
  
  /// Creates a new `JWT` with `headerValue` and `headerKey` for an **decrypted** JSON Web Token
  /// - Parameter jwt: JSON Web Token to authorize request
  /// - Returns: `JWT`
  static func decrypted(_ jwt: String) -> JWT {
    .init(value: jwt, headerValue: jwt, headerKey: "ENV-JWT")
  }
}
