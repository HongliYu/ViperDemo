//
//  Article.swift
//  ViperDemo
//
//  Created by Hongli Yu on 09.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

struct Article: Codable {

    let source: Source?
    let author: String?
    let title: String?
    let desc: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case desc = "description"
        case url
        case urlToImage
        case publishedAt
        case content
    }

}
