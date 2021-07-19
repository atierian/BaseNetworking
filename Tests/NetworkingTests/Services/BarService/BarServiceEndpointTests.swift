import XCTest
@testable import Networking

final class BarServiceEndpointTestCase: XCTestCase {
  
  func testPlacesEndpoint() throws {
    let placeEndpoint: BarServiceEndpoint = .places(searchText: "example")
    XCTAssertEqual(placeEndpoint.basePath, "/bar/v1")
    let paramsDict = Dictionary(
      uniqueKeysWithValues: placeEndpoint.parameters?
        .compactMap { ($0.name, $0.value) } ?? .init()
    )
    XCTAssertEqual(paramsDict["search"], "example")
    XCTAssertEqual(paramsDict["systemID"], "42")
    XCTAssertEqual(placeEndpoint.resource, "/bar/v1/places")
    XCTAssertNil(placeEndpoint.headers)
    
    let placeResponse = BarMockModel.placeData
    
    let endpointPlaceResponse = try placeEndpoint.response(placeResponse)
    XCTAssertEqual(endpointPlaceResponse.id, 75)
    XCTAssertEqual(endpointPlaceResponse.location.coordinates.latitude, 40.7682)
  }
  
  func testUserEndpoits() throws {
    let userEndpoint: BarServiceEndpoint = .users
    XCTAssertEqual(userEndpoint.basePath, "/bar/v1")
    XCTAssertNil(userEndpoint.parameters)
    XCTAssertEqual(userEndpoint.resource, "/bar/v1/users")
    XCTAssertNil(userEndpoint.headers)
    
    
    let userResponse = BarMockModel.userData
    
    let endpointUserResponse = try userEndpoint.response(userResponse)
    XCTAssertEqual(endpointUserResponse.id, 25)
    XCTAssertEqual(endpointUserResponse.name, "Ian")
  }
}
