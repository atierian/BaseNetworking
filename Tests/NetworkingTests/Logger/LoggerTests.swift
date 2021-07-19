import XCTest
@testable import Networking

final class LoggerTestCase: XCTestCase {
  func testInit() {
    var logger = Logger.debug
    XCTAssertEqual(logger.verbosity, 6)
        
    logger.log(label: "Debug", value: 42, level: .debug)
        
    DispatchQueue.global(qos: .background).async {
      var nilVal: Int?
      nilVal = nil
      logger.log(label: "BG nil", value: nilVal, level: .info)
    }
    
    logger = Logger.info
    XCTAssertEqual(logger.verbosity, 5)
    
    logger = Logger.notice
    XCTAssertEqual(logger.verbosity, 4)
    
    logger = Logger.warning
    XCTAssertEqual(logger.verbosity, 3)
    
    logger = Logger.error
    XCTAssertEqual(logger.verbosity, 2)
    logger.log(label: "Warning", value: 42, level: .warning)

    logger = Logger.critical
    XCTAssertEqual(logger.verbosity, 1)
    
    logger = Logger.none
    XCTAssertEqual(logger.verbosity, 0)
  }
  
  func testFormatter() {
    var logger: Logger = .debug.formatted(with: .lineBreakWithSpacer)
    logger.log(label: "Debug", value: 42, level: .debug)
    DispatchQueue.global(qos: .background).async {
      logger.log(label: "BG Thread", value: "hello world", level: .info)
    }
    
    logger = logger.formatted(with: .includingThreadInfo)
    logger.log(label: "Debug", value: 42, level: .debug)
    DispatchQueue.global(qos: .background).async {
      logger.log(label: "BG Thread", value: "hello world", level: .info)
    }
    
    logger = logger.formatted(with: .default)
    logger.log(label: "Debug", value: 42, level: .debug)
    DispatchQueue.global(qos: .background).async {
      logger.log(label: "BG Thread", value: "hello world", level: .info)
    }

  }
}
