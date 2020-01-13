//
//  NewsStatusCodeValidator.swift
//  ViperDemo
//
//  Created by Hongli Yu on 06.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

final class NewsStatusCodeValidator: DefaultStatusCodeValidator {
    private let successStatusCodes = [200]
    private let invalidStatusCodes = [403, 409, 418]

    override func validate(for response: URLResponse, data: Data?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            assertionFailure("Response should be of HTTPURLResponse type but got \(type(of: response))")
            throw WebServiceError.unknown
        }

        let statusCode = httpResponse.statusCode
        if successStatusCodes.contains(statusCode) {
            return
        } else if invalidStatusCodes.contains(statusCode) {
            let decoder = JSONDecoderEncoderBuilder().buildDecoder()
            if let data = data,
                let errorObject = try? decoder.decode(APIErrorObject.self, from: data),
                let error = errorObject.error {
                throw error
            } else {
                throw APIGenericError.generic(statusCode)
            }
        }

        try super.validate(for: response, data: data)
    }
}
