//
//  TextFieldController.swift
//  CPE
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class TextFieldController: UIViewController {
    var onDoneEditing: ((TextObject)->())?
    // MARK: - Private Views
    private var textField = UITextField()
    private var slider = UISlider()
    private var colorView = ColorsView()
    // MARK: - Private Text Object
    private var textObject = TextObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0.3
        view.backgroundColor = .black
        view.addSubview(textField.prepareLayout())
        view.addSubview(slider.prepareLayout())
        view.addSubview(colorView.prepareLayout())
        
        textField.centerAtSuperview()
        textField.widthAnchor ^= 300
        
        slider.topAnchor ^= textField.bottomAnchor + 10
        slider.leadingAnchor ^= textField.leadingAnchor
        slider.trailingAnchor ^= textField.trailingAnchor
        slider.setValue(1, animated: true)
        
        colorView.topAnchor ^= slider.bottomAnchor + 10
        colorView.leadingAnchor ^= textField.leadingAnchor
        colorView.trailingAnchor ^= textField.trailingAnchor
        colorView.onSelectColor = { self.textObject.color = $0 }
    }
}

extension TextFieldController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        textObject.string = text
        textObject.transparent = CGFloat(slider.value)
        onDoneEditing?(textObject)
        return true
    }
}
