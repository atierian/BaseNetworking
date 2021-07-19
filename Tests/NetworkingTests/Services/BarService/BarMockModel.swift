import Foundation
@testable import Networking

enum BarMockModel {
  static let placeData: Data = """
      {
        "id": 75,
        "name": "Pete's Hotdogs",
        "location": {
          "address": {
            "streetAddress": "123 main st.",
            "city": "somewhere",
            "state": "NV",
            "postalCode": "89412",
            "country": "USA"
          },
          "coordinates": {
            "latitude": 40.7682,
            "longitude": -199.2187
          }
        }
      }
      """.data(using: .utf8)!
    
  static let userData: Data = """
      {
        "id": 25,
        "name": "Ian"
      }
      """.data(using: .utf8)!
}
