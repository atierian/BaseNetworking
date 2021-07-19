import Foundation

/// Responsible for defining output format of collected information
public struct LogFormatter {
  /// Define format of log output from `LogInput`
  ///
  /// Open to create you're own format
  ///
  /// Preconfigured formats:
  /// - `.default`
  /// - `.includingThreadInfo`
  /// - `.lineBreakWithSpacer`
  public let format: (LogInput) -> String
}

// MARK: LogInput Definition
extension LogFormatter {
  
  /// Representation of log input
  public struct LogInput {
    /// Time stamp of log call in format `HH:mm:ss.SSS`
    let timeStamp: String
    
    /// Description of level for specific log entry
    ///
    ///  e.g. `DEBUG`
    ///
    /// `.none` has no description
    let logLevelDescription: String
    
    /// Specified label describing logged value
    let label: String
    
    /// Logged value
    let value: Any
    
    /// Function from which `log` was called
    let function: StaticString
    
    /// Line from which `log` was called
    let line: UInt
    
    /// Last path component of file from which `log` was called
    let file: String
    
    /// Initialize log input - for internal use
    /// - Parameters:
    ///   - timeStamp: Time stamp of log call in format `HH:mm:ss.SSS`
    ///   - logLevelDescription: Description of level for specific log entry
    ///   - label: Specified label describing logged value
    ///   - value: Logged value
    ///   - function: Function from which `log` was called
    ///   - line: Line from which `log` was called
    ///   - file: Last path component of file from which `log` was called
    internal init(
      timeStamp: String,
      logLevelDescription: String,
      label: String,
      value: Any,
      function: StaticString,
      line: UInt,
      file: String
    ) {
      self.timeStamp = timeStamp
      self.logLevelDescription = logLevelDescription
      self.label = label
      self.value = value
      self.function = function
      self.line = line
      self.file = file
    }
  }
}

