//
//  News.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 13.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import XCTest
@testable import ViperDemo

class NewsTests: XCTestCase {

    func testFetchNews() {
        let expectation = self.expectation(description: "testFetchNews")
        let service: NewsService = NewsServiceImpl()
        service.fetchNews { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articleList):
                    guard let articles = articleList.articles else { return }
                    XCTAssertTrue(articles.count > 0)
                case .failure(let error):
                    print(error ?? "error is nil")
                }
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5) { (error) in
            print(error.debugDescription)
        }
    }

}
