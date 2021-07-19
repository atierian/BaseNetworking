import Foundation

/// Example `Place` resource from `BarService`
struct BarPlace: Codable, Getable {
  let id: UInt
  let name: String
  let location: Location
}

// MARK: Nested BarPlace Types
extension BarPlace {
  struct Location: Codable {
    let address: Address
    let coordinates: Coordinates
  }
}

// MARK: Nested BarPlace.Location Types
extension BarPlace.Location {
  struct Address: Codable {
    let streetAddress: String
    let city: String
    let state: String
    let postalCode: String
    let country: String
  }
  struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
  }
}
