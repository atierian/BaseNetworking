import XCTest
@testable import Networking

final class EnvironmentTestCase: XCTestCase {
  func testSanbox() {
    let defaultNameSpaceEnvironment: Environment = .sandbox()
    XCTAssertEqual(defaultNameSpaceEnvironment.host, "default.sandbox.com")
    XCTAssertEqual(defaultNameSpaceEnvironment.hostWithScheme, "https://default.sandbox.com")
    
    let testNameSpaceEnvironment = Environment.sandbox(nameSpace: "test")
    XCTAssertEqual(testNameSpaceEnvironment.host, "test.sandbox.com")
    XCTAssertEqual(testNameSpaceEnvironment.hostWithScheme, "https://test.sandbox.com")
    
    XCTAssertNotEqual(defaultNameSpaceEnvironment, testNameSpaceEnvironment)
  }
  
  func testStaging() {
    let defaultSubdomainEnvironment: Environment = .staging()
    XCTAssertEqual(defaultSubdomainEnvironment.host, "user.staging.com")
    XCTAssertEqual(defaultSubdomainEnvironment.hostWithScheme, "https://user.staging.com")
    
    let staffSubdomainEnvironment = Environment.staging(subdomain: .staff)
    XCTAssertEqual(staffSubdomainEnvironment.host, "staff.staging.com")
    XCTAssertEqual(staffSubdomainEnvironment.hostWithScheme, "https://staff.staging.com")
    
    XCTAssertNotEqual(defaultSubdomainEnvironment, staffSubdomainEnvironment)
  }
  
  func testProduction() {
    let defaultSubdomainEnvironment: Environment = .production()
    XCTAssertEqual(defaultSubdomainEnvironment.host, "user.prod.com")
    XCTAssertEqual(defaultSubdomainEnvironment.hostWithScheme, "https://user.prod.com")
    
    let staffSubdomainEnvironment = Environment.production(subdomain: .staff)
    XCTAssertEqual(staffSubdomainEnvironment.host, "staff.prod.com")
    XCTAssertEqual(staffSubdomainEnvironment.hostWithScheme, "https://staff.prod.com")
    
    XCTAssertNotEqual(defaultSubdomainEnvironment, staffSubdomainEnvironment)
  }
}
