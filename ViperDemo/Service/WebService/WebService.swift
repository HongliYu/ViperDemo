//
//  WebService.swift
//  ViperDemo
//
//  Created by Hongli Yu on 03.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

enum RestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

enum WebServiceError: Error {
    case unknown
    case cancelled
    case timedOut
    case invalidURL
    case invalidStatusCode(Int)

    /// app will display login modally
    case unauthorized
    case noInternetConnection

    static let unauthorizedStatusCode: Int = 401
    static let cancelledCode: Int = NSURLErrorCancelled
    static let timedOutCode: Int = NSURLErrorTimedOut
    static let noInternetConnectionCode: Int = NSURLErrorNotConnectedToInternet
}

enum WebServiceResult {
    case success(Data, URLResponse?)
    case failure(Error?)
}

typealias WebServiceCompletion = (WebServiceResult) -> Void

protocol WebService {
    @discardableResult
    func call(endpoint path: String,
              queryItems: [URLQueryItem]?,
              body: Data?,
              method: RestHTTPMethod,
              meta: RequestMeta,
              completion: @escaping WebServiceCompletion) -> String?

    func cancel(task taskId: String)

    @discardableResult
    func execute(request: URLRequest,
                 meta: RequestMeta,
                 completion: @escaping WebServiceCompletion) -> String
}

protocol EndpointService {
    var webService: WebService { get }
}
