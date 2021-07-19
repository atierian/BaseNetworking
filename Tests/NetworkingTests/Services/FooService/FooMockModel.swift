import Foundation
@testable import Networking

enum FooMockModel {
  static let mealData: Data = """
      {
        "type": "breakfast",
        "calories": 307
      }
      """.data(using: .utf8)!
  
  static let mealObject: FooMeal = .init(type: .breakfast, calories: 307)
}
