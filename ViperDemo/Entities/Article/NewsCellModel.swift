//
//  NewsCellModel.swift
//  ViperDemo
//
//  Created by Hongli Yu on 07.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

class NewsCellModel {

    private var article: Article?

    init?(article: Article) {
        self.article = article
    }

    var author: String? {
        return article?.author
    }

    var title: String? {
        return article?.title
    }

    var desc: String? {
        return article?.desc
    }

    var content: String? {
        return article?.content
    }

    var publishedAt: String? {
        return article?.publishedAt?.asString(style: .full)
    }

    var imageURL: String? {
        return article?.urlToImage
    }

    var url: String? {
        return article?.url
    }

}
