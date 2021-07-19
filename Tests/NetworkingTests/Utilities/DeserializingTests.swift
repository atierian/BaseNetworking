import XCTest
@testable import Networking

final class DeserializingTestCase: XCTestCase {
  
  struct MockObject: Decodable, Equatable {
    let value: Int
  }
  
  let decoding: (Data) throws -> MockObject = {
    try JSONDecoder().decode(MockObject.self, from: $0)
  }
  
  func makeInputData(_ string: String) -> Data {
    string.data(using: .utf8)!
  }
  
  func successResult(with data: Data) -> Result<Data, NetworkError> {
    .success(data)
  }
    
  func testSuccess() throws {
    let successData = makeInputData(#"{ "value": 42 }"#)
    let resultInput = successResult(with: successData)

    let resultOutput = Deserializing.baseNetworkResult.deserialize((resultInput, decoding, .debug))
    guard case .success(let output) = resultOutput else {
      XCTFail()
      return
    }
    XCTAssertEqual(output, MockObject(value: 42))
  }
  
  func testKeyNotFound() {
    let keyNotFoundData = makeInputData(#"{ "foo": true }"#)
    let resultInput = successResult(with: keyNotFoundData)
    let resultOutput = Deserializing.baseNetworkResult.deserialize((resultInput, decoding, .error))
    guard case .failure(let error) = resultOutput else {
      XCTFail()
      return
    }
    XCTAssertEqual(error, .undecodableResponse)
  }
 
  func testValueNotFound() {
    let keyValueFoundData = makeInputData(#"{ "value": null }"#)
    let resultInput = successResult(with: keyValueFoundData)
    let resultOutput = Deserializing.baseNetworkResult.deserialize((resultInput, decoding, .error))
    guard case .failure(let error) = resultOutput else {
      XCTFail()
      return
    }
    XCTAssertEqual(error, .undecodableResponse)
  }
  
  func testDataCorrupted() {
    let dataCorrupted = makeInputData(#"{ "value": -- }"#)
    let resultInput = successResult(with: dataCorrupted)
    let resultOutput = Deserializing.baseNetworkResult.deserialize((resultInput, decoding, .error))
    guard case .failure(let error) = resultOutput else {
      XCTFail()
      return
    }
    XCTAssertEqual(error, .undecodableResponse)
  }
  
  func testTypeMismatch() {
    let typeMismatch = makeInputData(#"{ "value": "type mismatch" }"#)
    let resultInput = successResult(with: typeMismatch)
    let resultOutput = Deserializing.baseNetworkResult.deserialize((resultInput, decoding, .error))
    guard case .failure(let error) = resultOutput else {
      XCTFail()
      return
    }
    XCTAssertEqual(error, .undecodableResponse)
  }
  
  func testExhaustiveCatch() {
    class FailingDecoder: JSONDecoder {
      struct Fail: Error { }
      override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        throw Fail()
      }
    }
    
    let decoding: (Data) throws -> MockObject = {
      try FailingDecoder().decode(MockObject.self, from: $0)
    }
    
    let exhaustiveCatch = makeInputData(#"{ }"#)
    let resultInput = successResult(with: exhaustiveCatch)
    let resultOutput = Deserializing.baseNetworkResult.deserialize((resultInput, decoding, .error))
    
    guard case .failure(let error) = resultOutput else {
      XCTFail()
      return
    }
    XCTAssertEqual(error, .undecodableResponse)
  }
  
  func testResultFailure() {
    let inputError: NetworkError = .noData
    let resultInput: Result<Data, NetworkError> = .failure(inputError)
    
    let resultOutput = Deserializing.baseNetworkResult.deserialize((resultInput, decoding, .error))
    guard case .failure(let error) = resultOutput else {
      XCTFail()
      return
    }
    XCTAssertEqual(error, inputError)
  }
  
}
