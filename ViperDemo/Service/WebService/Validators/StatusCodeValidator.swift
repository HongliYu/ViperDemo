//
//  StatusCodeValidator.swift
//  ViperDemo
//
//  Created by Hongli Yu on 03.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

protocol StatusCodeValidator {
    func validate(for response: URLResponse, data: Data?) throws
}
