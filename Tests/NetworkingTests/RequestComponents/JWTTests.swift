import XCTest
@testable import Networking

final class JWTTestCase: XCTestCase {
  func testJWT() {
    let encrypted: JWT = .encrypted("123456")
    XCTAssertEqual(encrypted.value, "123456")
    XCTAssertEqual(encrypted.headerKey, "Cookie")
    XCTAssertEqual(encrypted.headerValue, "encryptedJWT=123456")
    
    let decrypted: JWT = .decrypted("654321")
    XCTAssertEqual(decrypted.value, "654321")
    XCTAssertEqual(decrypted.headerKey, "ENV-JWT")
    XCTAssertEqual(decrypted.headerValue, "654321")
  }
}
