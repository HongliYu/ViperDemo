//
//  EntitiesGenerator.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 07.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation
@testable import ViperDemo

final class EntitiesGenerator {

    func createArticles() -> ArticleList {
        var articles = [Article]()
        let source = Source(identifier: "cnn", name: "CNN")

        let article = Article(source: source,
                              author: "Analysis by Stephen Collinson, CNN",
                              title: "Judge tells Trump he's not a king -- the President is not so sure - CNN",
                              desc: "Donald Trump is not going to like his Constitution 101 lesson: \"Presidents are not kings.\"",
                              url: "https://www.cnn.com/2019/11/26/politics/donald-trump-constitution-supreme-court-executive-power/index.html",
                              urlToImage: "https://cdn.cnn.com/cnnnext/dam/assets/191116154126-01-donald-trump-1114-super-tease.jpg",
                              publishedAt: DateFormatter.iso8601Full.date(from: "2019-11-26T11:40:00Z") ?? Date(),
                              content: "")
        articles.append(article)
        return ArticleList(status: "ok", totalResults: 10, articles: articles)
    }

}
