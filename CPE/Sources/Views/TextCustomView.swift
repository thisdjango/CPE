//
//  TextCustomView.swift
//  CPE
//
//  Created by Diana Tsarkova on 27.01.2021.
//  Copyright © 2021 Diana Tsarkova. All rights reserved.
//

import UIKit

class TextCustomView: UIView {
    var onDoneEditing: ((TextObject)->())?
    // MARK: - Private Views
    private var textField = UITextField()
    private var slider = UISlider()
    private var colorView = ColorsView()
    // MARK: - Private Text Object
    private var textObject = TextObject()
    private var addButton = UIButton(type: .contactAdd)
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
        backgroundColor = .clear
        addSubview(textField.prepareLayout())
        addSubview(slider.prepareLayout())
        addSubview(colorView.prepareLayout())
        addSubview(addButton.prepareLayout())
        
        textField.becomeFirstResponder()
        textField.centerAtSuperview()
        textField.widthAnchor ^= 300
        textField.delegate = self
        
        slider.topAnchor ^= textField.bottomAnchor + 10
        slider.leadingAnchor ^= textField.leadingAnchor
        slider.trailingAnchor ^= textField.trailingAnchor
        slider.setValue(1, animated: true)
        slider.addTarget(self, action: #selector(changeTransparency(_ :)), for: .valueChanged)
        
        colorView.topAnchor ^= slider.bottomAnchor + 10
        colorView.leadingAnchor ^= leadingAnchor
        colorView.trailingAnchor ^= trailingAnchor
        colorView.heightAnchor ^= 30
        colorView.isUserInteractionEnabled = true
        colorView.onSelectColor = { [weak self] color in
            self?.textObject.color = color
            self?.textField.textColor = color
        }
        
        addButton.topAnchor ^= colorView.bottomAnchor + 10
        addButton.leadingAnchor ^= leadingAnchor
        addButton.trailingAnchor ^= trailingAnchor
        addButton.addTarget(self, action: #selector(done), for: .touchUpInside)
    }
    
    @objc func dismiss() {
        endEditing(true)
    }
    @objc func done() {
        onDoneEditing?(textObject)
    }
    @objc func changeTransparency(_ sender: UISlider) {
        textObject.transparent = CGFloat(sender.value)
        textField.alpha = CGFloat(sender.value)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension TextCustomView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        textObject.string = text
    }
}
