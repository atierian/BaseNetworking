import XCTest
@testable import Networking

final class FooServiceTestCase: XCTestCase {
  
  let endpoint: FooServiceEndpoint = .meals
  
  func testPostRequestFailure() throws {
    
    let mockUploadTaskFailure: MockUploadTask = .data(.init(count: 1))
    let mockDataTaskFailure: MockDataTask = .data(.init(count: 1))
    
    let mockRequestDispatcherFailure = NetworkRequestDispatcher(
      mockDataTaskFailure.dataTask,
      mockUploadTaskFailure.uploadTask
    )
    
    let baseFailure = BaseNetworker(mockRequestDispatcherFailure)
    let fooServiceFailure = FooService(baseFailure)
    
    let mockRequestData = FooMockModel.mealData
    let mockRequestBody = try JSONDecoder().decode(FooMeal.self, from: mockRequestData)
    
    fooServiceFailure.post(endpoint, body: mockRequestBody) { result in
      guard case .failure(let error) = result else {
        XCTFail("expected failure")
        return
      }
      XCTAssertEqual(error, .undecodableResponse)
    }
  }
  
  func testPostRequestSuccess() throws {
    let mockResponseData = FooMockModel.mealData
    let mockDataTaskSuccess: MockDataTask = .data(mockResponseData)
    let mockUploadTaskSuccess: MockUploadTask = .data(mockResponseData)
    let mockRequestDispatcher = NetworkRequestDispatcher(
      mockDataTaskSuccess.dataTask,
      mockUploadTaskSuccess.uploadTask
    )
    let base = BaseNetworker(mockRequestDispatcher)
    let mockRequestBody = try JSONDecoder().decode(FooMeal.self, from: mockResponseData)
    let fooService = FooService(base)
    
    fooService.post(endpoint, body: mockRequestBody) { result in
      guard case .success(let meal) = result else {
        XCTFail("request failed")
        return
      }
      XCTAssertEqual(meal.calories, 307)
      XCTAssertEqual(meal.type, .breakfast)
    }
    
    let postRequestConfiguration = FooService.PostRequest(
      endpoint: endpoint,
      body: mockRequestBody,
      environment: .sandbox(nameSpace: "example"),
      logger: .debug) { result in
      
      guard case .success(let meal) = result else {
        XCTFail("request failed")
        return
      }
      XCTAssertEqual(meal.calories, 307)
      XCTAssertEqual(meal.type, .breakfast)
    }
    
    fooService.post(serviceRequest: postRequestConfiguration)
  }
}
