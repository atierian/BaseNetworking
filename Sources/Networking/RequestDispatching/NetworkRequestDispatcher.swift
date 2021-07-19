import Foundation

public struct NetworkRequestDispatcher: NetworkRequestDispatchable {

  let dataTask: DataTask
  let uploadTask: UploadTask
  
  /// Create a new `NetworkRequestDispatcher` instance to make network requests
  /// - Parameters:
  ///   - dataTask: Modeled after its default argument `URLSession.shared.dataTask` and enables a consumer to inject their own dependency for testing.
  ///   - uploadTask: Modeled after its default argument `URLSession.shared.uploadTask` and enables a consumer to inject their own dependency for testing.
  init(
    _ dataTask: @escaping DataTask = URLSession.shared.dataTask,
    _ uploadTask: @escaping UploadTask = URLSession.shared.uploadTask
  ) {
    self.dataTask = dataTask
    self.uploadTask = uploadTask
  }

  // Documentation provided by NetworkRequestDispatchable protocol
  public func get(
    request: URLRequest,
    logger: Logger,
    completion: @escaping CompletionHandler<Data>
  ) {
    dataTask(request) { data, response, error in
      completion(resultForResponse(data, response, error, logger))
    }.resume()
  }

  // Documentation provided by NetworkRequestDispatchable protocol
  public func delete(
    request: URLRequest,
    logger: Logger,
    completion: @escaping CompletionHandler<Void>
  ) {
    dataTask(request) { data, response, error in
      logger.log(label: "Network Error", value: error.debugDescription, level: .error)
      logger.log(label: "Response Status Code", value: (response as? HTTPURLResponse)?.statusCode, level: .info)
      logger.log(label: "Server Response", value: response, level: .debug)

      guard let response = response as? HTTPURLResponse,
            [200, 202, 204].contains(response.statusCode)
      else {
        logger.log(label: "Delete Request Failed", value: "", level: .error)
        completion(.failure(.deleteRequestFailed))
        return
      }
      logger.log(label: "Delete Request Succeeded", value: "", level: .info)
      completion(.success)
    }.resume()
  }

  // Documentation provided by NetworkRequestDispatchable protocol
  public func put(
    request: URLRequest,
    body: Data,
    logger: Logger,
    completion: @escaping CompletionHandler<Data>
  ) {
    uploadTask(request, body) { data, response, error in
      completion(resultForResponse(data, response, error, logger))
    }.resume()
  }

  // Documentation provided by NetworkRequestDispatchable protocol
  public func post(
    request: URLRequest,
    body: Data,
    logger: Logger,
    completion: @escaping CompletionHandler<Data>
  ) {
    uploadTask(request, body) { data, response, error in
      completion(resultForResponse(data, response, error, logger))
    }.resume()
  }
  
  /// Generate `Result<Data, NetworkError>` from request response
  /// - Parameters:
  ///   - data: Request response data
  ///   - response: Request response
  ///   - error: Request response error
  ///   - logger: Logger instance for logging information
  /// - Returns: `Result<Data, NetworkError>` to be given to completion handler
  private func resultForResponse(
    _ data: Data?,
    _ response: URLResponse?,
    _ error: Error?,
    _ logger: Logger
  ) -> Result<Data, NetworkError> {
    logger.log(label: "Network Error", value: error.debugDescription, level: .error)
    logger.log(label: "Response Status Code", value: (response as? HTTPURLResponse)?.statusCode, level: .info)
    logger.log(label: "Server Response", value: response, level: .debug)
    guard let data = data else {
      return .failure(.noData)
    }
    return .success(data)
  }
}
