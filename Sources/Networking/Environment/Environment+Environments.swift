import Foundation

extension Environment {
  /// Sandbox environment
  /// - Parameter nameSpace: subdomain / namespace
  /// - Returns: Environment with `<nameSpace>.sandbox.com` host
  public static func sandbox(nameSpace: String = "default") -> Self {
    .init(host: "\(nameSpace).sandbox.com")
  }
  
  /// Staging environment
  /// - Parameter subdomain: Target subdomain. `.user` is default argument
  /// - Returns: `user.staging.com` or `staff.staging.com` depending on `subdomain`
  public static func staging(subdomain: TargetSubdomain = .user) -> Self {
    .init(host: "\(subdomain.rawValue).staging.com")
  }
  
  /// Production environment
  /// - Parameter subdomain: Target subdomain. `.user` is default argument
  /// - Returns: `user.prod.com` or `staff.prod.com` depending on `subdomain`
  public static func production(subdomain: TargetSubdomain = .user) -> Self {
    .init(host: "\(subdomain.rawValue).prod.com")
  }
}
