//
//  MockNewsInteractorInput.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 07.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

@testable import ViperDemo

final class MockNewsInteractorInput: NewsInteractorInput, HasInvocations {

    enum Invocation: FakeEquatable {
        case fetchNews
        case fetchNewsHistory
    }
    var invocations: [Invocation] = []

    func fetchNews() {
        invocations.append(.fetchNews)
    }

    func fetchNewsHistory() {
        invocations.append(.fetchNewsHistory)
    }

}
