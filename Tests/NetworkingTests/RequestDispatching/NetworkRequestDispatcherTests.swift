import XCTest
@testable import Networking

final class NetworkRequestDispatcherTestCase: XCTestCase {
  func testResultForResponseFailure() {
    let mockTask = MockDataTask()
    let requestDispatcher = NetworkRequestDispatcher(
      mockTask.dataTask
    )
    let request = URLRequest(url: URL(string: "https://apple.com")!)
    requestDispatcher.get(request: request, logger: .debug) { result in
      guard case .failure(let error) = result else {
        XCTFail()
        return
      }
      XCTAssertEqual(error, .noData)
    }
  }
  
  func testResultForResponseSuccess() {
    let mockTask = MockDataTask.data(.init())
    let requestDispatcher = NetworkRequestDispatcher(
      mockTask.dataTask
    )
    let request = URLRequest(url: URL(string: "https://apple.com")!)
    requestDispatcher.get(request: request, logger: .debug) { result in
      guard case .success(let data) = result else {
        XCTFail()
        return
      }
      XCTAssertEqual(data, .init())
    }
  }
  
  func testInit() {
    _ = NetworkRequestDispatcher()
  }
}
