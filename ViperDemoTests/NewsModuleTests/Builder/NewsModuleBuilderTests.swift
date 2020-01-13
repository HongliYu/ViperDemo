//
//  NewsModuleBuilderTests.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 07.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import XCTest
@testable import ViperDemo

final class NewsModuleBuilderTests: XCTestCase {

    func testBuild() {
        // given
        let builder = NewsModuleBuilder()

        // when
        let vc = builder.build() as? NewsViewController

        // then
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc?.output)

        let presenter = vc?.output as? NewsPresenter
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter?.view)
        XCTAssertNotNil(presenter?.router)
        XCTAssertNotNil(presenter?.interactor)

        let router = presenter?.router as? NewsRouter
        XCTAssertNotNil(router)

        let interactor = presenter?.interactor as? NewsInteractor
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor?.output)
    }
}
