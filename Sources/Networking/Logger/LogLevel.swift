import Foundation

/// Defines level for log entry
struct LogLevel {
  
  /// Level
  let verbosity: UInt8
  
  /// Description - included in log ouput
  let description: String
}

// Preconfigured `LogLevel` definitions
extension LogLevel {
  static let debug = LogLevel(verbosity: 6, description: "DEBUG")
  static let info = LogLevel(verbosity: 5, description: "INFO")
  static let notice = LogLevel(verbosity: 4, description: "NOTICE")
  static let warning = LogLevel(verbosity: 3, description: "WARNING")
  static let error = LogLevel(verbosity: 2, description: "ERROR")
  static let critical = LogLevel(verbosity: 1, description: "CRITICAL")
  static let none = LogLevel(verbosity: 0, description: "")
}
