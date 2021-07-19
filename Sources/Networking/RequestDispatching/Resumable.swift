import Foundation

/// Conformance requires implementation of single method `resume()`
///
/// Allows client to mock requests made in `NetworkRequestDispatchable` conforming object
public protocol Resumable {
  func resume()
}

// TODO: Consider alternative methods to mock task
extension URLSessionDataTask: Resumable { }
