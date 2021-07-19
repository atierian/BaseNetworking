import Foundation

/// Leading dot syntax access to HTTP Methods
public enum HTTPMethod: String {
  
  /// For a `GET` request
  case get = "GET"
  
  /// For a `POST` request
  case post = "POST"
  
  /// For a `PUT` request
  case put = "PUT"
  
  /// For a `DELETE` request
  case delete = "DELETE"
}
