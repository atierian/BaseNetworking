import Foundation

struct Deserializing<A, B: Decodable, C> {
  let deserialize: (A) -> C
}

extension Deserializing where A == (Result<Data, NetworkError>, (Data) throws -> B, Logger), C == Result<B, NetworkError> {
  
  static var baseNetworkResult: Deserializing {
    .init { result, transform, logger in
      switch result {
      case let .success(data):
        logger.log(label: "JSON Response", value: data.prettyPrintedJSON, level: .debug)
        do {
          return .success(try transform(data))
        }
        catch let DecodingError.dataCorrupted(context) {
          logger.log(
            label: "Decoding Error - Corrupted Data Context",
            value: context.debugDescription,
            level: .error
          )
          return .failure(.undecodableResponse)
        }
        catch let DecodingError.keyNotFound(key, context) {
          logger.log(
            label: "Decoding Error - Key Not Found",
            value: "Key '\(key)' not found: \(context.debugDescription)\nCoding Path: \(context.codingPath)",
            level: .error
          )
          return .failure(.undecodableResponse)
        }
        catch let DecodingError.valueNotFound(value, context) {
          logger.log(
            label: "Decoding Error - Value Not Found",
            value: "Value '\(value)' not found: \(context.debugDescription)\nCoding Path: \(context.codingPath)",
            level: .error
          )
          return .failure(.undecodableResponse)
        }
        catch let DecodingError.typeMismatch(type, context)  {
          logger.log(
            label: "Decoding Error - Type Mismatch",
            value: "Type '\(type)' mismatch: \(context.debugDescription)\nCoding Path: \(context.codingPath)",
            level: .error
          )
          return .failure(.undecodableResponse)
        }
        catch {
          logger.log(
            label: "Decoding Error - Other",
            value: error.localizedDescription,
            level: .error
          )
          return .failure(.undecodableResponse)
        }
      case let .failure(error):
        logger.log(label: "Failure Response", value: error.rawValue, level: .error)
        return .failure(error)
      }
    }
  }
}
