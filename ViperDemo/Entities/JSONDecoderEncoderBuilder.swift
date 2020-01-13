//
//  JSONDecoderEncoderBuilder.swift
//  ViperDemo
//
//  Created by Hongli Yu on 06.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

struct JSONDecoderEncoderBuilder {

    func buildDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom(customDateFormatter)
        return decoder
    }

    func buildEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
        return encoder
    }

    func customDateFormatter(_ decoder: Decoder) throws -> Date {
        let dateString = try decoder.singleValueContainer().decode(String.self)
        if let date = DateFormatter.iso8601Full.date(from: dateString) {
            return date
        } else if let date = DateFormatter.iso8601.date(from: dateString) {
            return date
        } else if let date = DateFormatter.dateOnly.date(from: dateString) {
            return date
        }

        throw EncodingError
            .invalidValue(dateString,
                          EncodingError.Context(codingPath: [],
                                                debugDescription: "Unable to encode date from \(dateString)."))
    }

}

extension DateFormatter {

    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    static let iso8601: ISO8601DateFormatter = {
        return ISO8601DateFormatter()
    }()

    static let dateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

}
