//
//  MockNavigationViewController.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 08.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import UIKit

final class MockNavigationViewController: UINavigationController, HasInvocations {

    enum Invocation: FakeEquatable {
        case push
        case pop
        case setViewControllers
    }
    var invocations: [Invocation] = []

    var pushedVC: UIViewController?
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        invocations.append(.push)
        pushedVC = viewController
        super.pushViewController(viewController, animated: false)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        invocations.append(.pop)
        return super.popViewController(animated: false)
    }

    var afterSetViewControllers: [UIViewController]?
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        invocations.append(.setViewControllers)
        afterSetViewControllers = viewControllers
        super.setViewControllers(viewControllers, animated: false)
    }
}
