import XCTest
@testable import Networking

final class URLComponentsInitTestCase: XCTestCase {
  private struct Endpoint: Endpointable {
    typealias Model = DataModel
    struct DataModel: Codable, AllHTTPMethods { }
    
    var response: (Data) throws -> DataModel = { _ in .init() }
    var resource: String = "/test"
    var headers: [HTTPHeader]?
    var parameters: [URLQueryItem]?
  }
  
  func testCustomInit() {
    let endpoint = Endpoint()
    let environment = Environment.staging()
    
    do {
      let components = URLComponents(endpoint: endpoint, environment: environment)
      XCTAssertEqual(components.host, "user.staging.com")
      XCTAssertEqual(components.path, "/test")
      XCTAssertEqual(components.url?.absoluteString, "https://user.staging.com/test")
    }
    
    do {
      let components = URLComponents(scheme: "http", endpoint: endpoint, environment: environment)
      XCTAssertEqual(components.scheme, "http")
    }
  }
  
  func testGetableInit() {
    var endpoint = Endpoint()

    let parameters = [
      URLQueryItem(name: "testName", value: "testValue")
    ]
    
    do {
      let components = URLComponents(endpoint: endpoint, environment: .staging(), parameters: parameters)
      XCTAssertEqual(components.host, "user.staging.com")
      XCTAssertEqual(components.scheme, "https")
      XCTAssertEqual(components.path, "/test")
      XCTAssertEqual(components.queryItems?.first(where: { $0.name == "testName" })?.value, "testValue")
    }

    do {
      endpoint.parameters = [
        .init(name: "search", value: "foo")
      ]
      let components = URLComponents(endpoint: endpoint, environment: .sandbox(nameSpace: "example"), parameters: parameters)
      XCTAssertEqual(components.host, "example.sandbox.com")
      XCTAssertEqual(components.queryItems?.count, 2)
    }
    
    do {
      endpoint.parameters?.append(.init(name: "testName", value: "shouldNotExistInQuery"))
      let components = URLComponents(endpoint: endpoint, environment: .production(), parameters: parameters)
      XCTAssertEqual(components.host, "user.prod.com")
      XCTAssertEqual(components.queryItems?.first(where: { $0.name == "testName" })?.value, "testValue")
    }
    
    do {
      _ = endpoint.parameters?.popLast()
      let components = URLComponents(endpoint: endpoint, environment: .production(), parameters: nil)
      XCTAssertNil(components.queryItems?.first(where: { $0.name == "testName" }))
      XCTAssertEqual(components.queryItems?.first(where: { $0.name == "search" })?.value, "foo")
    }

  }
}
