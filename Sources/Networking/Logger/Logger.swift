import Foundation

// Logger Levels
extension Logger {
  public static let debug = Logger(verbosity: 6)
  public static let info = Logger(verbosity: 5)
  public static let notice = Logger(verbosity: 4)
  public static let warning = Logger(verbosity: 3)
  public static let error = Logger(verbosity: 2)
  public static let critical = Logger(verbosity: 1)
  public static let none = Logger(verbosity: 0)
}

/// Responsible for printed collected logs to the debug console
public struct Logger {
  
  /// Level defined for this instance. Logs with a verbosity `<=` this value will be printed
  let verbosity: UInt8
  
  /// Determines console output based on `LogInput`
  var formatter: LogFormatter
  
  /// Creates a new `Logger` instance - Levels defined in extension
  /// - Parameter verbosity: Level of logging verbosity
  fileprivate init(verbosity: UInt8) {
    self.verbosity = verbosity
    self.formatter = .default
  }
  
  /// Add formatter to existing `Logger`
  /// - Parameter formatter: Use a predefined `LogFormatter` or create your own - see example
  /// - Returns: `Logger`
  ///
  /// Create your own `LogFormatter` example
  /// ~~~~
  /// .debug
  ///   .formatted(
  ///     with: LogFormatter(
  ///     format: { input in
  ///       return "\(input.timeStamp)|\(input.value)"
  ///     }
  ///   )
  /// )
  /// ~~~~
  public func formatted(with formatter: LogFormatter) -> Logger {
    .init(verbosity: verbosity, formatter: formatter)
  }
  
  /// Initialize a `Logger` - For use by `formatted(with:)`
  /// - Parameters:
  ///   - verbosity: Logging Verbosity Level
  ///   - formatter: `LogFormatter`
  private init(verbosity: UInt8, formatter: LogFormatter) {
    self.verbosity = verbosity
    self.formatter = formatter
  }
  
  /// Prints log message to debug console
  /// - Parameters:
  ///   - label: Specified label describing logged value
  ///   - value: Logged value
  ///   - level: Level for specific log entry
  ///   - function: Function from which `log` is called
  ///   - line: Line from which `log` is called
  ///   - file: Last path component of file from which `log` is called
  func log<T>(
    label: String,
    value: @autoclosure () -> T,
    level: LogLevel,
    function: StaticString = #function,
    line: UInt = #line,
    file: String = #file
  ) {
    #if DEBUG
    guard level.verbosity <= verbosity else { return }
    print(
      formatter.format(
        .init(
          timeStamp: logTimeStamp,
          logLevelDescription: level.description,
          label: label,
          value: value(),
          function: function,
          line: line,
          file: file
        )
      )
    )
    #endif
  }
  
  /// Time stamp of log in `HH:mm:ss.SSS` format
  private var logTimeStamp: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss.SSS"
    return formatter.string(from: Date())
  }
}
