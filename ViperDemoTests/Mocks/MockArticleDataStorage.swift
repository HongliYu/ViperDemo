//
//  MockArticleDataStorage.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 09.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation
@testable import ViperDemo

final class MockArticleDataStorage: ArticleDataStorage, HasInvocations {

    enum Invocation: FakeEquatable {
        case store(Article)
        case storeArticles([Article])
        case load(Date)
        case loadRecent(Int)
    }

    var invocations: [Invocation] = [] {
        didSet {
            invocationsDidChange?()
        }
    }

    var invocationsDidChange: (() -> Void)?
    var mockedArticle: Article?
    var mockedArticles: [Article]?
    var error: Error?

    func store(_ article: Article, completion: @escaping (Error?) -> Void) {
        mockedArticle = article
        invocations.append(.store(article))
        completion(error)
    }

    func store(_ articles: [Article], completion: @escaping (Error?) -> Void) {
        invocations.append(.storeArticles(articles))
    }

    func load(from: Date, completion: @escaping (ArticleDataStorageResult<[Article]>) -> Void) {
        invocations.append(.load(from))
    }

    var articleDataStorageResult: ArticleDataStorageResult<[Article]>!
    func loadRecent(numerOfItems: Int, completion: @escaping (ArticleDataStorageResult<[Article]>) -> Void) {
        invocations.append(.loadRecent(numerOfItems))
        completion(articleDataStorageResult)
    }

}
