import Foundation

struct Serializing<A, B, C, D> {
  let serialize: (A) -> C
}

extension Serializing where A == (B, Logger, D), B: Encodable, C == Data?, D == JSONEncoder {
  static var json: Serializing {
    .init { body, logger, encoder in
      do {
        let body = try encoder.encode(body)
        logger.log(label: "Body Successfully Encoded", value: dump(body), level: .debug)
        return body
      } catch let EncodingError.invalidValue(value, context) {
        logger.log(
          label: "Encoding Error - Invalid Value",
          value: "Value: \(value)\nContext: \(context.debugDescription) at Coding Path: \(context.codingPath)",
          level: .error
        )
        return nil
      } catch {
        logger.log(
          label: "Encoding Error - Unkown",
          value: "Error: \(error)",
          level: .error
        )
        return nil
      }
    }
  }
}
