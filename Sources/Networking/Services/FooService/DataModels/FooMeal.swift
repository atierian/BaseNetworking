import Foundation

/// Example `Meal` resource from `FooService`
public struct FooMeal: Codable, AllHTTPMethods {
  let type: MealType
  let calories: Double
}

// MARK: Nested FooMeal Types
extension FooMeal {
  public enum MealType: String, Codable {
    case breakfast
    case lunch
    case dinner
    case snack
  }
}
