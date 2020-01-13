//
//  NewsInteractorTests.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 07.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import XCTest
@testable import ViperDemo

final class NewsInteractorTests: XCTestCase {

    var interactor: NewsInteractor!
    var output: MockNewsInteractorOutput!
    var newsService: MockNewsService!
    var dataStorage: MockArticleDataStorage!

    override func setUp() {
        super.setUp()

        output = MockNewsInteractorOutput()
        newsService = MockNewsService()
        dataStorage = MockArticleDataStorage()
        interactor = NewsInteractor(newsService: newsService, dataStorage: dataStorage)
        interactor.output = output
    }

    override func tearDown() {
        output = nil
        newsService = nil
        dataStorage = nil
        interactor = nil

        super.tearDown()
    }

    func testFetchNews() {
        // given
        let articleList = EntitiesGenerator().createArticles()
        newsService.newsServiceResult = .success(articleList)
        let expect = expectation(description: "testFetchNews expectation")
        output.invocationsDidChange = {
            if self.output.invocations.contains(.didReceive(articleList)) {
                expect.fulfill()
            }
        }

        // when
        interactor.fetchNews()

        // then
        newsService.checkInvocations([.fetchNews])
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchNewsHistory() {
        // given
        let articleList = EntitiesGenerator().createArticles()
        dataStorage.articleDataStorageResult = .success(articleList.articles!)
        let expect = expectation(description: "testFetchNewsHistory expectation")
        output.invocationsDidChange = {
            if self.output.invocations.contains(.didReceive(articleList)) {
                expect.fulfill()
            }
        }

        // when
        interactor.fetchNewsHistory()

        // then
        dataStorage.checkInvocations([.loadRecent(10)])
        waitForExpectations(timeout: 5, handler: nil)
    }

}
