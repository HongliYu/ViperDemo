//
//  Environment.swift
//  ViperDemo
//
//  Created by Hongli Yu on 03.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

enum Environment: String {

    case debug
    case staging
    case release

    var scheme: String {
        return "https"
    }

    var APIVersion: String {
        return "v2"
    }

    var baseURL: String {
        switch self {
        case .debug:
            return "newsapi.org"
        case .staging:
            return "newsapi.org"
        case .release:
            return "newsapi.org"
        }
    }

}
