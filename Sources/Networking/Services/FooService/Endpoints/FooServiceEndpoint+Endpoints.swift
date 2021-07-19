import Foundation

extension FooServiceEndpoint {
  ///Endpoint `/meals` for `FooMeal`
  static var meals: FooServiceEndpoint<FooMeal> { "/meals" }
}

// Kinda neat, but a bad idea and just to demonstrate the capabilities of ExpressibleBy...
extension FooServiceEndpoint: ExpressibleByStringLiteral {
  /// This is a bad idea and just to demonstrate the capabilities of ExpressibleBy...
  /// - Parameter value: Value of `resource` property
  init(stringLiteral value: StringLiteralType) {
    self.init(resource: value)
  }
}
