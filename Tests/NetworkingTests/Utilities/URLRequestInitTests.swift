import XCTest
@testable import Networking

final class URLRequestInitTestCase: XCTestCase {
  private struct Endpoint: Endpointable {
    typealias Model = DataModel
    struct DataModel: Codable, AllHTTPMethods { }
    
    var response: (Data) throws -> DataModel = { _ in .init() }
    var resource: String = "/test"
    var headers: [HTTPHeader]?
    var parameters: [URLQueryItem]?
  }
  
  func testCustomInit() {
    var endpoint = Endpoint()
    endpoint.headers = [
      .init(key: "Test-Key", value: "test-value")
    ]
    
    let url = URL(string: "https://example.com" + endpoint.resource)!

    do {
      let method: HTTPMethod = .post
      let jwt: JWT = .decrypted("123456-098765")
      let headers: [HTTPHeader] = [
        .init(key: "Test-Key", value: "test-value-2")
      ]
      let referer = "https://apple.com"
      
      // Subject under test
      let request = URLRequest(
        url: url,
        endpoint: endpoint,
        headers: headers,
        method: method,
        jwt: jwt,
        referer: referer
      )
      
      let requestHeaders = request.allHTTPHeaderFields
      
      // headers passed in overwrite endpoint headers with the same key
      XCTAssertEqual(requestHeaders?["Test-Key"], "test-value-2")
      // referer argument is set to Referer key
      XCTAssertEqual(requestHeaders?["Referer"], "https://apple.com")
      // decrypted JWT added with key ENV-JWT
      XCTAssertEqual(requestHeaders?["ENV-JWT"], "123456-098765")
      // HTTP method set to POST
      XCTAssertEqual(request.httpMethod, "POST")
      // URL string properly set
      XCTAssertEqual(request.url?.absoluteString, "https://example.com/test")
    }

    do {
      let method: HTTPMethod = .get
      let jwt: JWT = .encrypted("123456-098765")
      
      // Subject under test
      let request = URLRequest(
        url: url,
        endpoint: endpoint,
        headers: nil,
        method: method,
        jwt: jwt
      )
      
      let requestHeaders = request.allHTTPHeaderFields
      
      // Content-Type header properly set
      XCTAssertEqual(requestHeaders?["Content-Type"], "application/json")
      // encrypted JWT added with key ENV-JWT
      XCTAssertEqual(requestHeaders?["Cookie"], "encryptedJWT=123456-098765")
      // HTTP method set to GET
      XCTAssertEqual(request.httpMethod, "GET")
    }
    
    do {
      let method: HTTPMethod = .put
      
      // Subject under test
      let request = URLRequest(
        url: url,
        endpoint: endpoint,
        headers: nil,
        method: method,
        jwt: nil
      )
      
      // HTTP method set to PUT
      XCTAssertEqual(request.httpMethod, "PUT")
    }
    
    do {
      let method: HTTPMethod = .delete
      
      // Subject under test
      let request = URLRequest(
        url: url,
        endpoint: endpoint,
        headers: nil,
        method: method,
        jwt: nil
      )
      
      // HTTP method set to DELETE
      XCTAssertEqual(request.httpMethod, "DELETE")
    }
  }
}
