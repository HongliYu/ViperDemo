//
//  Source.swift
//  ViperDemo
//
//  Created by Hongli Yu on 09.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

struct Source: Codable {

    let identifier: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }

}
