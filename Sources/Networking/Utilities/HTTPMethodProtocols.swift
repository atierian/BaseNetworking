import Foundation

/// Conformance defined at Data Model level. Allows for conforming data models to participate in `GET` requests.
public protocol Getable {}
/// Conformance defined at Data Model level. Allows for conforming data models to participate in `POST` requests.
public protocol Postable {}
/// Conformance defined at Data Model level. Allows for conforming data models to participate in `PUT` requests.
public protocol Putable {}
/// Conformance defined at Data Model level. Allows for conforming data models to participate in `DELETE` requests.
public protocol Deleteable {}

public typealias AllHTTPMethods = Getable & Postable & Putable & Deleteable
