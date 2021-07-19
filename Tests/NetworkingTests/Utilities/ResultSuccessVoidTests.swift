import XCTest
@testable import Networking

final class ResultSuccessVoidTestCase: XCTestCase {
  func testInit() throws {
    let result: Result<Void, Error> = .success
    guard case .success = result else {
      XCTFail()
      return
    }
  }
}
