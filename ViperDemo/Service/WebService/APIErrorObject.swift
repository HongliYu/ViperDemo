//
//  APIErrorObject.swift
//  ViperDemo
//
//  Created by Hongli Yu on 06.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

struct APIErrorObject: Decodable {

    let error: Error?

    struct CodeKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }

    private enum CodingKeys: String, CodingKey {
        case msg
        case codes
    }

    enum UserError: String, Error {
        case notApproved = "not_approved"
        case hasExistingReservation = "has_existing_reservation"
        case createConflict = "create_conflict"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let codes = try container.nestedContainer(keyedBy: CodeKey.self, forKey: .codes)
        var error: Error?
        for key in codes.allKeys {
            guard error == nil else { break }
            switch key.stringValue {
            case "user":
                if let value = try? codes.decode(String.self, forKey: key) {
                    error = UserError(rawValue: value)
                }
            default:
                break
            }
        }
        self.error = error
    }

}

enum APIGenericError: Error {
    case generic(Int)
}

extension APIGenericError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .generic(let statusCode):
            switch statusCode {
            case 403:
                return "403 error"
            default:
                return "Generic error"
            }
        }
    }

}
