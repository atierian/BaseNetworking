import XCTest
@testable import Networking

final class BaseNetworkerTestCase: XCTestCase {
  
  func testBadURL() {
    let base = BaseNetworker(
      .init(
        MockDataTask().dataTask,
        MockUploadTask().uploadTask
      )
    )
    
    var mockEndpoint = MockEndpoint()
    // creates bad url by no leading / in path
    mockEndpoint.resource = "test"
        
    func handle<T>(_ result: Result<T, NetworkError>) {
      guard case .failure(let error) = result else {
        XCTFail()
        return
      }
      XCTAssertEqual(error, .badURL)
    }
    
    base.get(endpoint: mockEndpoint, environment: .sandbox(), jwt: nil, parameters: nil, headers: nil, logger: .debug, completion: handle)
    
    base.post(endpoint: mockEndpoint, body: MockDataModel(id: "123"), environment: .sandbox(), jwt: nil, headers: nil, referer: nil, logger: .debug, completion: handle)
    
    base.put(endpoint: mockEndpoint, environment: .sandbox(), body: MockDataModel(id: "123"), jwt: nil, headers: nil, referer: nil, logger: .debug, completion: handle)
    
    base.delete(endpoint: mockEndpoint, environment: .sandbox(), jwt: nil, headers: nil, referer: nil, logger: .debug, completion: handle)
  }
  
  func testBadBody() {
    let base = BaseNetworker(
      .init(
        MockDataTask().dataTask,
        MockUploadTask().uploadTask
      )
    )
            
    func handle<T>(_ result: Result<T, NetworkError>) {
      guard case .failure(let error) = result else {
        XCTFail()
        return
      }
      XCTAssertEqual(error, .unencodableBody)
    }
            
    base.post(endpoint: MockEndpoint(), body: Float.infinity, environment: .sandbox(), jwt: nil, headers: nil, referer: nil, logger: .debug, completion: handle)
    
    base.put(endpoint: MockEndpoint(), environment: .sandbox(), body: Float.infinity, jwt: nil, headers: nil, referer: nil, logger: .debug, completion: handle)
  }
  
  
  func testGetSuccess() {
    let mockDataTask: MockDataTask = .data(MockDataModel.data)
    let base = BaseNetworker(
      .init(
        mockDataTask.dataTask,
        MockUploadTask().uploadTask
      )
    )
    
    base.get(endpoint: MockEndpoint(), environment: .sandbox(), jwt: nil, parameters: nil, headers: nil, logger: .debug) { result in
      guard case .success(let mock) = result else {
        XCTFail()
        return
      }
      XCTAssertEqual(mock.id, "123")
    }
  }
  
  func testPostSuccess() {
    let mockUploadTask: MockUploadTask = .data(MockDataModel.data)
    let base = BaseNetworker(
      .init(
        MockDataTask().dataTask,
        mockUploadTask.uploadTask
      )
    )
    
    base.post(endpoint: MockEndpoint(), body: MockDataModel(id: "123"), environment: .sandbox(), jwt: nil, headers: nil, referer: nil, logger: .debug) { result in
      guard case .success(let mock) = result else {
        XCTFail()
        return
      }
      XCTAssertEqual(mock.id, "123")
    }
  }
  
  func testPutSuccess() {
    let mockUploadTask: MockUploadTask = .data(MockDataModel.data)
    let base = BaseNetworker(
      .init(
        MockDataTask().dataTask,
        mockUploadTask.uploadTask
      )
    )
    
    base.put(endpoint: MockEndpoint(), environment: .sandbox(), body: MockDataModel(id: "123"), jwt: nil, headers: nil, referer: nil, logger: .debug) { result in
      guard case .success(let mock) = result else {
        XCTFail()
        return
      }
      XCTAssertEqual(mock.id, "123")
    }
  }
  
  func testDeleteSuccess() {
    let response = HTTPURLResponse(url: .init(string: "https://apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    let mockDataTask: MockDataTask = .response(response)
    let base = BaseNetworker(
      .init(
        mockDataTask.dataTask,
        MockUploadTask().uploadTask
      )
    )
    
    base.delete(endpoint: MockEndpoint(), environment: .sandbox(), jwt: nil, headers: nil, referer: nil, logger: .debug) { result in
      guard case .success = result else {
        XCTFail()
        return
      }
    }
  }
  
  func testDeleteFailure() {
    let response = HTTPURLResponse(url: .init(string: "https://apple.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    let mockDataTask: MockDataTask = .response(response)
    let base = BaseNetworker(
      .init(
        mockDataTask.dataTask,
        MockUploadTask().uploadTask
      )
    )
    
    base.delete(endpoint: MockEndpoint(), environment: .sandbox(), jwt: nil, headers: nil, referer: nil, logger: .debug) { result in
      guard case .failure(let error) = result else {
        XCTFail()
        return
      }
      XCTAssertEqual(error, .deleteRequestFailed)
    }
  }
}
