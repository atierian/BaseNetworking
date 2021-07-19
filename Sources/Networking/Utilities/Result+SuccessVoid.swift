import Foundation

public extension Result where Success == Void {
  /// Allows for `.success` when `Result.Success == Void`
    static var success: Result { .success(()) }
}
