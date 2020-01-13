//
//  WebServiceImpl.swift
//  ViperDemo
//
//  Created by Hongli Yu on 03.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

final class WebServiceImpl: WebService {

    private let session: URLSession
    private let requestTimeout: TimeInterval
    private var tasksCache: [String: URLRequest] = [:]

    convenience init(requestTimeout: TimeInterval = 30) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = requestTimeout
        let session = URLSession(configuration: sessionConfig)
        self.init(requestTimeout: requestTimeout, session: session)
    }

    init(requestTimeout: TimeInterval, session: URLSession) {
        self.requestTimeout = requestTimeout
        self.session = session
    }

    @discardableResult
    func call(endpoint path: String,
              queryItems: [URLQueryItem]?,
              body: Data?,
              method: RestHTTPMethod,
              meta: RequestMeta,
              completion: @escaping WebServiceCompletion) -> String? {
        do {
            let request = try buildRequest(endpoint: path,
                                           queryItems: queryItems,
                                           body: body,
                                           method: method)
            executeTask(with: request,
                        meta: meta,
                        completion: completion)

            return request.url!.absoluteString
        } catch let error {
            completion(.failure(error))
        }

        return nil
    }

    func cancel(task taskId: String) {
        session.getAllTasks { tasks in
            let task = tasks.first(where: { task in
                return task.originalRequest?.url?.absoluteString ==  taskId
            })
            task?.cancel()
        }
    }

    @discardableResult
    func execute(request: URLRequest,
                 meta: RequestMeta,
                 completion: @escaping WebServiceCompletion) -> String {
        executeTask(with: request,
                    meta: meta,
                    completion: completion)

        return request.url!.absoluteString
    }

    // MARK: - Private
    private func createSession() -> URLSession {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = requestTimeout
        return URLSession(configuration: sessionConfig)
    }

    private func buildRequest(endpoint path: String,
                              queryItems: [URLQueryItem]?,
                              body: Data?,
                              method: RestHTTPMethod) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = Environment.debug.scheme
        components.host = Environment.debug.baseURL
        components.path = path
        components.queryItems = queryItems
        guard let requestURL = components.url else {
            assertionFailure("Failed to construct URL")
            throw WebServiceError.invalidURL
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }

    private func executeTask(with request: URLRequest,
                             meta: RequestMeta,
                             completion: @escaping WebServiceCompletion) {
        //  Authentications
        //        var requestWithHeaders = request
        //        if let authToken = userManager.authToken {
        //            let authValue = "\(authToken)"
        //            requestWithHeaders.setValue(authValue, forHTTPHeaderField: "Authorization")
        //        }

        let requestWithHeaders = request
        let task = session.dataTask(with: requestWithHeaders) { [weak self] (data, response, error) in
            self?.handleTaskResult(request: requestWithHeaders,
                                   data: data,
                                   response: response,
                                   error: error,
                                   meta: meta,
                                   completion: completion)
        }
        task.resume()
    }

    private func handleTaskResult(request: URLRequest,
                                  data: Data?,
                                  response: URLResponse?,
                                  error: Error?,
                                  meta: RequestMeta,
                                  completion: @escaping WebServiceCompletion) {
        guard let data = data, let response = response, error == nil else {
            print(error ?? "error is nil")
            return
        }
        do {
            try meta.statusCodeValidator.validate(for: response, data: data)
            completion(.success(data, response))
        } catch let error {
            completion(.failure(error))
        }
    }

}
