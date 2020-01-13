//
//  NewsRouterTests.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 08.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import XCTest
@testable import ViperDemo

final class NewsRouterTests: XCTestCase {

    var router: NewsRouter!
    var viewController: MockViewController!
    var navigationController: MockNavigationViewController!

    override func setUp() {
        super.setUp()

        router = NewsRouter()
        viewController = MockViewController()
        navigationController = MockNavigationViewController(rootViewController: viewController)
        router.viewController = viewController
    }

    override func tearDown() {
        router = nil
        viewController = nil
        navigationController = nil

        super.tearDown()
    }

    func testDisplayNewsDetails() {
        // given
        let articles = EntitiesGenerator().createArticles()
        navigationController.invocations = []

        // when
        guard let usrlString = articles.articles?.first?.url else {
            return
        }
        router.displayNewsDetails(urlString: usrlString)

        // then
        navigationController.checkInvocations([.push])
        XCTAssertNotNil(navigationController.pushedVC as? NewsDetailViewController)
    }

}
