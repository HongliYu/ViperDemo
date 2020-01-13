//
//  MockNewsInteractorOutput.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 07.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

@testable import ViperDemo

final class MockNewsInteractorOutput: NewsInteractorOutput, HasInvocations {

    enum Invocation: FakeEquatable {
        case didReceive(ArticleList)
    }

    var invocations: [Invocation] = [] {
        didSet {
            invocationsDidChange?()
        }
    }
    var invocationsDidChange: (() -> Void)?

    func didReceive(_ articleList: ArticleList) {
        invocations.append(.didReceive(articleList))
    }

}
