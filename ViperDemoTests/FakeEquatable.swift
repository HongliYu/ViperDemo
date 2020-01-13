//
//  FakeEquatable.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 07.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

protocol FakeEquatable: Equatable {
    var fakeValue: String { get }
}

extension FakeEquatable {
    var fakeValue: String {
        return String(describing: self)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.fakeValue == rhs.fakeValue
    }
}
