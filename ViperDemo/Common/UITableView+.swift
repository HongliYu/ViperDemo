//
//  UITableView+.swift
//  ViperDemo
//
//  Created by Hongli Yu on 09.01.20.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import UIKit

extension UITableView {

    func registerCell(cellTypes: [AnyClass]) {
        for cellType in cellTypes {
            let typeString = String(describing: cellType)
            let xibPath = Bundle(for: cellType).path(forResource: typeString, ofType: "nib")
            if xibPath == nil {
                self.register(cellType, forCellReuseIdentifier: typeString)
            } else {
                self.register(UINib(nibName: typeString, bundle: nil), forCellReuseIdentifier: typeString)
            }
        }
    }

}
