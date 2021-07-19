import XCTest
@testable import Networking

final class SerializingTestCase: XCTestCase {
  
  func testSuccess() throws {
    struct TestEncodable: Encodable {
      let foo: String
    }
    
    let testEncodable = TestEncodable(foo: "hello")
    let data = Serializing.json.serialize((testEncodable, .debug, JSONEncoder()))
    
    let testData = try JSONEncoder().encode(testEncodable)
    XCTAssertEqual(data, testData)
  }
  
  func testInvalidValueFailure() {
    let nonJSONEncodable = Float.infinity
    let data = Serializing.json.serialize((nonJSONEncodable, .error, JSONEncoder()))
    XCTAssertNil(data)
  }
  
  func testExhaustiveCatch() {
    class FailingEncoder: JSONEncoder {
      struct FailingEncoderError: Error { }
      override func encode<T>(_ value: T) throws -> Data where T : Encodable {
        throw FailingEncoderError()
      }
    }
    
    let data = Serializing.json.serialize(("", .error, FailingEncoder()))
    XCTAssertNil(data)
  }
}
