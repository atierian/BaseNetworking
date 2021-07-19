import Foundation

protocol NetworkRequestDispatchable {

  typealias DataTask = (
    _ request: URLRequest,
    _ completion: @escaping (
      _ data: Data?,
      _ response: URLResponse?,
      _ error: Error?
    ) -> Void) -> Resumable

  typealias UploadTask = (
    _ request: URLRequest,
    _ body: Data,
    _ completion: @escaping (
      _ data: Data?,
      _ response: URLResponse?,
      _ error: Error?
    ) -> Void) -> Resumable
  
  /// `NetworkRequestDispatchable.DataTask`
  ///
  /// This is modeled after `URLSession.shared.dataTask` and enables a client to inject their own dependency for testing.
  /// ~~~
  /// // Definition
  ///  (URLRequest,
  ///   @escaping (
  ///     Data?,
  ///     URLResponse?,
  ///     Error?
  ///    ) -> Void) -> Resumable
  /// ~~~
  var dataTask: DataTask { get }
  
  /// `NetworkRequestDispatchable.UploadTask`
  ///
  /// This is modeled after `URLSession.shared.uploadTask` and enables a client to inject their own dependency for testing.
  /// Used for and request that includes a `body`
  /// ~~~
  /// // Definition
  ///  (URLRequest,
  ///   @escaping (
  ///     Data?,
  ///     URLResponse?,
  ///     Error?
  ///    ) -> Void) -> Resumable
  /// ~~~
  var uploadTask: UploadTask { get }
  
  /// Make a `GET` request
  /// - Parameters:
  ///   - request: `URLRequest` to make
  ///   - logger: `Logger` instance to log any applicable information gathered.
  ///   - completion: Completion handler - returns `Result<Data, NetworkError>`
  func get(
    request: URLRequest,
    logger: Logger,
    completion: @escaping CompletionHandler<Data>
  )
  /// Make a `POST` request
  /// - Parameters:
  ///   - request: `URLRequest` to make
  ///   - body: Body in `Data` form to include in request
  ///   - logger: `Logger` instance to log any applicable information gathered.
  ///   - completion: Completion handler - returns `Result<Data, NetworkError>`
  func post(
    request: URLRequest,
    body: Data,
    logger: Logger,
    completion: @escaping CompletionHandler<Data>
  )

  /// Make a `PUT` request
  /// - Parameters:
  ///   - request: `URLRequest` to make
  ///   - body: Body in `Data` form to include in request
  ///   - logger: `Logger` instance to log any applicable information gathered.
  ///   - completion: Completion handler - returns `Result<Data, NetworkError>`
  func put(
    request: URLRequest,
    body: Data,
    logger: Logger,
    completion: @escaping CompletionHandler<Data>
  )

  /// Make a `DELETE` request
  /// - Parameters:
  ///   - request: `URLRequest` to make
  ///   - logger: `Logger` instance to log any applicable information gathered.
  ///   - completion: Completion handler - returns `Result<Void, NetworkError>`
  func delete(
    request: URLRequest,
    logger: Logger,
    completion: @escaping CompletionHandler<Void>
  )
}
