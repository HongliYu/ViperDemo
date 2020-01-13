//
//  CoreDataEntityConverter.swift
//  ViperDemo
//
//  Created by Hongli Yu on 08.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

protocol CoreDataEntityConverter {
    associatedtype BusinessObject

    func convertToBO() -> BusinessObject?
    func populate(with object: BusinessObject) throws
}

enum CoreDataConverterError: Error {
    case missingContext
}
