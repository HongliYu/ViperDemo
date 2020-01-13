//
//  UserManager.swift
//  ViperDemo
//
//  Created by Hongli Yu on 03.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

protocol UserManager {
    var isLoggedIn: Bool { get }
    var isPaymentAdded: Bool { get }
    var isPromoCodeAdded: Bool { get }
    var authToken: String? { get }
    var currentUser: User? { get }

    func handle(authToken: String)
    func handle(user: User)
    func logout()
}

struct User {}
