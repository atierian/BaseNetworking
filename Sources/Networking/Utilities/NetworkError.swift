import Foundation

// TODO: Needs to be expanded upon, potentially include Associated Values or consider alternative data type.
public enum NetworkError: String, Error {
  /// Response returned with an HTTP status code that was not `200`,` 202`, or` 204`
  case deleteRequestFailed
  /// No data returned from request expected data in response
  case noData
  /// Request body could not be encoded - check logs for encoding error context. The network request did not fire.
  case unencodableBody
  /// URL initialization failed. The network request did not fire.
  case badURL
  /// Response could not be decoded - check logs for decoding error context.
  case undecodableResponse
}
