import Foundation

// Preconfigured formatting options for Logger
extension LogFormatter {
  /**
   Log Output Formatter `.standard`
   
   Format
   ~~~~
   [TimeStamp:LogLevel] [FileName:Line] [Function] [Label:Value]
   ~~~~
   */
  static var `default`: LogFormatter {
    .init { input in
      let fileName = (input.file as NSString).lastPathComponent
      return "[\(input.timeStamp):\(input.logLevelDescription)] [\(fileName):\(input.line)] [\(input.function)] [\(input.label): \(input.value)]"
    }
  }
  
  /**
   Log Output Formatter `.includingThreadInfo`
   
   Format
   ~~~~
   [TimeStamp:LogLevel] [FileName:Line] [Function] [Thread:ThreadID] [Label:Value]
   ~~~~
   */
  static var includingThreadInfo: LogFormatter {
    .init { input in
      let fileName = (input.file as NSString).lastPathComponent
      let thread = Thread.isMainThread ? "MAIN" : "BG"
      let threadID = String(format: "%x", pthread_mach_thread_np(pthread_self()))
      return "[\(input.timeStamp):\(input.logLevelDescription)] [\(fileName):\(input.line)] [\(input.function)] [\(thread):\(threadID)] [\(input.label): \(input.value)]"
    }
  }
  
  /**
   Log Output Formatter `.lineBreakWithSpacer`
   
   Format
   ~~~~
   [TimeStamp : LogLevel]
   [FileName : Line]
   [Function]
   [Thread : ThreadID]
   [Label : Value]
   ~~~~
   */
  static var lineBreakWithSpacer: LogFormatter {
    .init { input in
      let fileName = (input.file as NSString).lastPathComponent
      let thread = Thread.isMainThread ? "MAIN" : "BG"
      let threadID = String(format: "%x", pthread_mach_thread_np(pthread_self()))
      return """
      [\(input.timeStamp) : \(input.logLevelDescription)]
      [\(fileName) : \(input.line)]
      [\(input.function)]
      [\(thread) : \(threadID)]
      [\(input.label) : \(input.value)]
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      """
    }
  }
}
