import XCTest
@testable import Networking

final class FooServiceEndpointTestCase: XCTestCase {
  
  func testEndpoints() {
    let mealEndpoint: FooServiceEndpoint = .meals
    XCTAssertEqual(mealEndpoint.basePath, "/foo-service/v1")
    XCTAssertNil(mealEndpoint.parameters)
    XCTAssertEqual(mealEndpoint.resource, "/foo-service/v1/meals")
    XCTAssertNil(mealEndpoint.headers)
    
    let mealResponse = FooMockModel.mealData
    XCTAssertEqual(try mealEndpoint.response(mealResponse).type, .breakfast)
    XCTAssertEqual(try mealEndpoint.response(mealResponse).calories, 307)
  }
}
