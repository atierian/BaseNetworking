import Foundation

extension Data {
  /// Returns a pretty printed JSON representation as `NSString?`
  ///
  /// Used for logging / debugging
  var prettyPrintedJSON: NSString? {
    do {
      let object = try JSONSerialization.jsonObject(with: self)
      let data = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .withoutEscapingSlashes])
      return NSString(data: data, encoding: String.Encoding.utf8.rawValue)
    }
    catch {
      return nil
    }
  }
}

