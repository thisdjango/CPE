//
//  UIView.swift
//  CPE
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

extension UIView {
    
    func prepareLayout() -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func pin(to sides: [Side] = [], const: [CGFloat] = [0, 0, 0, 0], view: UIView, excluded: Side = .nul) {
        // For changing
        var thisSides = sides
        // Flex logic
        if sides.isEmpty { thisSides = [.top, .bottom, .left, .right] }
        // Exclude logic
        thisSides = thisSides.filter{ $0 != excluded }
        // Constraints activation for filtered array
        for side in thisSides {
            switch side {
            case .top:
                topAnchor.constraint(equalTo: view.topAnchor, constant: const[0]).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -const[1]).isActive = true
            case .left:
                leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const[2]).isActive = true
            case .right:
                trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -const[3]).isActive = true
            case .nul:
                print("nul")
            }
        }
    }
}
