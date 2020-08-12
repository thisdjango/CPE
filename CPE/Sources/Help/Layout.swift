//
//  Layout.swift
//  CPE
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit


@discardableResult func ~=(lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> Bool {
    lhs.constraint(equalTo: rhs).isActive = true
    return lhs.constraint(equalTo: rhs).isActive
}

@discardableResult func ~=(lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> Bool {
    lhs.constraint(equalTo: rhs).isActive = true
    return lhs.constraint(equalTo: rhs).isActive
}

func +(lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: lhs, constant: rhs)
}

func +(lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: lhs, constant: rhs)
}
