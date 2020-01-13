//
//  MockWebService.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 07.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation
@testable import ViperDemo

final class MockWebService: WebService, HasInvocations {
    enum Invocation: FakeEquatable {
        case call(String, [URLQueryItem]?, Data?, RestHTTPMethod)
        case cancel(String)
        case executeRequest
    }
    var invocations: [Invocation] = []

    var result: WebServiceResult!

    var taskId: String?
    func call(endpoint path: String,
              queryItems: [URLQueryItem]?,
              body: Data?,
              method: RestHTTPMethod,
              meta: RequestMeta,
              completion: @escaping WebServiceCompletion) -> String? {
        invocations.append(.call(path, queryItems, body, method))
        completion(result)
        taskId = path
        return path
    }

    func cancel(task taskId: String) {
        invocations.append(.cancel(taskId))
    }

    func execute(request: URLRequest,
                 meta: RequestMeta,
                 completion: @escaping WebServiceCompletion) -> String {
        invocations.append(.executeRequest)
        completion(result)
        taskId = request.url!.absoluteString
        return request.url!.absoluteString
    }
}
