import Foundation
@testable import Networking

struct MockEndpoint: Endpointable {
  typealias Model = MockDataModel
  
  var response: (Data) throws -> Model = { try JSONDecoder().decode(Model.self, from: $0) }
  var resource: String = "/test"
  var headers: [HTTPHeader]?
  var parameters: [URLQueryItem]?
}

struct MockDataModel: Codable, AllHTTPMethods {
  let id: String
}

extension MockDataModel {
  static let data: Data = """
    {
      "id": "123"
    }
    """.data(using: .utf8)!
}
