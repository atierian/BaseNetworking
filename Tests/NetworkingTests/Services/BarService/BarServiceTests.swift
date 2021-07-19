import XCTest
@testable import Networking

final class BarServiceTestCase: XCTestCase {
  let usersEndpoint: BarServiceEndpoint = .users
  let placesEndpoint: BarServiceEndpoint = .places(searchText: "test")
  
  func testUsersSuccess() {
    let mockResponseData = BarMockModel.userData
    let mockDataTaskSuccess: MockDataTask = .data(mockResponseData)
    let mockUploadTaskSuccess: MockUploadTask = .data(mockResponseData)
    let mockRequestDispatcher = NetworkRequestDispatcher(
      mockDataTaskSuccess.dataTask,
      mockUploadTaskSuccess.uploadTask
    )
    let base = BaseNetworker(mockRequestDispatcher)
    let barService = BarService(base)
    
    barService.get(usersEndpoint, environment: .sandbox(), logger: .debug) { result in
      guard case .success(let user) = result else {
        XCTFail("request failed")
        return
      }
      XCTAssertEqual(user.id, 25)
      XCTAssertEqual(user.name, "Ian")
      
    }
    
    // Configured Request
    let getRequestConfiguration = BarService.GetRequest(
      endpoint: usersEndpoint,
      environment: .staging(),
      jwt: nil,
      parameters: nil,
      headers: nil,
      logger: .debug) { result in
      guard case .success(let user) = result else {
        XCTFail("request failed")
        return
      }
      XCTAssertEqual(user.id, 25)
      XCTAssertEqual(user.name, "Ian")
    }
    
    barService.get(serviceRequest: getRequestConfiguration)
  }
  
  func testUsersFailure() {
    let mockUploadTaskFailure: MockUploadTask = .data(.init(count: 1))
    let mockDataTaskFailure: MockDataTask = .data(.init(count: 1))
    
    let mockRequestDispatcherFailure = NetworkRequestDispatcher(
      mockDataTaskFailure.dataTask,
      mockUploadTaskFailure.uploadTask
    )
    
    let baseFailure = BaseNetworker(mockRequestDispatcherFailure)
    let barServiceFailure = BarService(baseFailure)
    
    barServiceFailure.get(usersEndpoint) { result in
      guard case .failure(let error) = result else {
        XCTFail("expected failure")
        return
      }
      XCTAssertEqual(error, .undecodableResponse)
    }
  }
  
  func testPlacesSuccess() {
    let mockResponseData = BarMockModel.placeData
    let mockDataTaskSuccess: MockDataTask = .data(mockResponseData)
    let mockUploadTaskSuccess: MockUploadTask = .data(mockResponseData)
    let mockRequestDispatcher = NetworkRequestDispatcher(
      mockDataTaskSuccess.dataTask,
      mockUploadTaskSuccess.uploadTask
    )
    let base = BaseNetworker(mockRequestDispatcher)
    let barService = BarService(base)
    
    barService.get(placesEndpoint, environment: .sandbox(), logger: .debug) { result in
      guard case .success(let place) = result else {
        XCTFail("request failed")
        return
      }
      XCTAssertEqual(place.id, 75)
      XCTAssertEqual(place.location.coordinates.latitude, 40.7682)
      
    }
    
    // Configured Request
    let getRequestConfiguration = BarService.GetRequest(
      endpoint: placesEndpoint,
      environment: .staging(),
      jwt: nil,
      parameters: nil,
      headers: nil,
      logger: .debug) { result in
      guard case .success(let place) = result else {
        XCTFail("request failed")
        return
      }
      XCTAssertEqual(place.name, "Pete's Hotdogs")
      XCTAssertEqual(place.location.address.postalCode, "89412")
    }
    
    barService.get(serviceRequest: getRequestConfiguration)
  }
  
  func testPlacesFailure() {
    let mockUploadTaskFailure: MockUploadTask = .data(.init(count: 1))
    let mockDataTaskFailure: MockDataTask = .data(.init(count: 1))
    
    let mockRequestDispatcherFailure = NetworkRequestDispatcher(
      mockDataTaskFailure.dataTask,
      mockUploadTaskFailure.uploadTask
    )
    
    let baseFailure = BaseNetworker(mockRequestDispatcherFailure)
    let barServiceFailure = BarService(baseFailure)
    
    barServiceFailure.get(placesEndpoint) { result in
      guard case .failure(let error) = result else {
        XCTFail("expected failure")
        return
      }
      XCTAssertEqual(error, .undecodableResponse)
    }
  }
}
