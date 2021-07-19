import Foundation

/// Example `User` resource from `BarService`
struct BarUser: Codable, Getable {
  let id: UInt
  let name: String
}
