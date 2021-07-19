import Foundation

/// Conformance requires implementation of single property `base`
///
/// Allows client to mock `BaseNetworkable` conforming object
protocol Service {
  /// Creates requests to be ultimately dispatched.
  var base: BaseNetworkable { get }
}
