import XCTest
@testable import Networking

final class HTTPHeaderTestCase: XCTestCase {
  func testInit() {
    let header = HTTPHeader(key: "someKey", value: "someValue")
    XCTAssertEqual(header.key, "someKey")
    XCTAssertEqual(header.value, "someValue")
  }
}
