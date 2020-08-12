//
//  TextFieldController.swift
//  CPE
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class TextFieldController: UIViewController {
    var textField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField.prepareLayout())
        textField.leadingAnchor ~= view.leadingAnchor + 10
    }
}
