import XCTest
@testable import Networking

final class DataPrettyPrintedJSONTestCase: XCTestCase {
  func testPrettyPrinted() {
    let json = """
      {
        "foo" : 42,
        "bar" : "hi"
      }
      """
    let data = json.data(using: .utf8)!
    
    let prettyPrinted = data.prettyPrintedJSON
    XCTAssertEqual(prettyPrinted, json as NSString)
  }
  
  func testPrettyPrintedFailure() {
    let json = """
      {
        "foo : 42,
        "bar" : "hi"
      }
      """
    let data = json.data(using: .utf8)!
    
    let prettyPrinted = data.prettyPrintedJSON
    XCTAssertNil(prettyPrinted)
  }
}
