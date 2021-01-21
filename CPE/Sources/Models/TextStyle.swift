//
//  Text.swift
//  CPE
//
//  Created by Diana Tsarkova on 06.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class TextObject {
    var font: UIFont
    var color: UIColor
    var string: String
    var transparent: CGFloat
    
    init(font f: String, size s: Int, color c: UIColor) {
        font = UIFont(name: f, size: CGFloat(s)) ?? UIFont.systemFont(ofSize: CGFloat(s))
        color = c
        string = ""
        transparent = 1
    }
    init() {
        font = UIFont.systemFont(ofSize: 16)
        color = .white
        string = ""
        transparent = 1
    }
}
