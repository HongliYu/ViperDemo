//
//  ArticleList.swift
//  ViperDemo
//
//  Created by Hongli Yu on 06.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

struct ArticleList: Codable {

    let status: String?
    let totalResults: Int?
    let articles: [Article]?

    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }

}
