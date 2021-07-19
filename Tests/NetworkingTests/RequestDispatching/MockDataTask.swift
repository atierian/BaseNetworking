import Foundation
@testable import Networking

struct MockDataTask: Resumable {
  var data: Data?
  var response: URLResponse?
  var error: Error?
  
  func dataTask(_ request: URLRequest, _ completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) -> Resumable {
    completion(data, response, error)
    return self
  }
  
  func resume() { }
  
  static func data(_ data: Data) -> MockDataTask {
    .init(data: data, response: nil, error: nil)
  }
  
  static func response(_ response: URLResponse) -> MockDataTask {
    .init(data: nil, response: response, error: nil)
  }
  
  static func error(_ error: Error) -> MockDataTask {
    .init(data: nil, response: nil, error: error)
  }
}
