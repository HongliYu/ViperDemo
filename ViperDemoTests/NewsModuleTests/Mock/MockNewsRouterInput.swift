//
//  MockNewsRouterInput.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 07.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

@testable import ViperDemo

final class MockNewsRouterInput: NewsRouterInput, HasInvocations {

    enum Invocation: FakeEquatable {
        case displayNewsDetails(String)
    }
    var invocations: [Invocation] = []

    func displayNewsDetails(urlString: String) {
        invocations.append(.displayNewsDetails(urlString))
    }

}
