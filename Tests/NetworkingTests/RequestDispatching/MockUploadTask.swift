import Foundation
@testable import Networking

struct MockUploadTask: Resumable {
  var data: Data?
  var response: URLResponse?
  var error: Error?
  
  func uploadTask(
    _ request: URLRequest,
    _ body: Data,
    _ completion:
      @escaping (
        _ data: Data?,
        _ response: URLResponse?,
        _ error: Error?
      ) -> Void
  ) -> Resumable {
    completion(data, response, error)
    return self
  }
  
  func resume() { }
  
  static func data(_ data: Data) -> MockUploadTask {
    .init(data: data, response: nil, error: nil)
  }
  
  static func response(_ response: URLResponse) -> MockUploadTask {
    .init(data: nil, response: response, error: nil)
  }
  
  static func error(_ error: Error) -> MockUploadTask {
    .init(data: nil, response: nil, error: error)
  }
}
