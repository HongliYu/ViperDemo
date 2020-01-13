//
//  MockNewsViewInput.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 07.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

@testable import ViperDemo

final class MockNewsViewInput: NewsViewInput, HasInvocations {

    enum Invocation: FakeEquatable {
        case display([NewsCellModel])
    }
    var invocations: [Invocation] = []

    func display(_ cellModels: [NewsCellModel]) {
        invocations.append(.display(cellModels))
    }

}
