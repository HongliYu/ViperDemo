//
//  NewsPresenterTests.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 07.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import XCTest
@testable import ViperDemo

final class NewsPresenterTests: XCTestCase {

    var presenter: NewsPresenter!
    var view: MockNewsViewInput!
    var interactor: MockNewsInteractorInput!
    var router: MockNewsRouterInput!

    override func setUp() {
        super.setUp()

        view = MockNewsViewInput()
        interactor = MockNewsInteractorInput()
        router = MockNewsRouterInput()

        presenter = NewsPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
    }

    override func tearDown() {
        view = nil
        interactor = nil
        router = nil
        presenter = nil

        super.tearDown()
    }

    func testViewIsReady() {
        // given

        // when
        presenter.viewIsReady()

        // then
        XCTAssertEqual(interactor.invocations[0], .fetchNewsHistory)
        XCTAssertEqual(interactor.invocations[1], .fetchNews)
    }

}
