//
//  MockNewsService.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 07.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

@testable import ViperDemo

final class MockNewsService: NewsService, HasInvocations {

    enum Invocation: FakeEquatable {
        case fetchNews
    }
    var invocations: [Invocation] = []

    let webService: WebService = MockWebService()

    var newsServiceResult: NewsServiceResult<ArticleList>!
    func fetchNews(completion: @escaping NewsListCompletion) {
        invocations.append(.fetchNews)
        completion(newsServiceResult)
    }

}
