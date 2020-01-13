//
//  MockViewController.swift
//  ViperDemoTests
//
//  Created by Hongli Yu on 08.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import UIKit

final class MockViewController: UIViewController, HasInvocations {

    enum Invocation: FakeEquatable {
        case dismiss
        case present
        case addChild
    }
    var invocations: [Invocation] = []

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        invocations.append(.dismiss)
        super.dismiss(animated: false, completion: nil)
        completion?()
    }

    var presentedVC: UIViewController?
    override func present(_ viewControllerToPresent: UIViewController,
                          animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        presentedVC = viewControllerToPresent
        invocations.append(.present)
        super.present(viewControllerToPresent, animated: false, completion: completion)
    }

    var addedChild: UIViewController?
    override func addChild(_ childController: UIViewController) {
        addedChild = childController
        invocations.append(.addChild)
        super.addChild(childController)
    }
}
