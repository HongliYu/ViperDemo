//
//  DefaultStatusCodeValidator.swift
//  ViperDemo
//
//  Created by Hongli Yu on 06.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

class DefaultStatusCodeValidator: StatusCodeValidator {
    private let successStatusCodes = [200]

    func validate(for response: URLResponse, data: Data?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            assertionFailure("Response should be of HTTPURLResponse type but got \(type(of: response))")
            throw WebServiceError.unknown
        }

        guard successStatusCodes.contains(httpResponse.statusCode) else {
            if httpResponse.statusCode == WebServiceError.unauthorizedStatusCode {
                throw WebServiceError.unauthorized
            }
            throw WebServiceError.invalidStatusCode(httpResponse.statusCode)
        }
    }

}
