//
//  ColorCell.swift
//  CPE
//
//  Created by Diana Tsarkova on 02.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
    static let cellId = "colorCell"
    // MARK: - private props
    private var colorView = UIView()
    // MARK: - public method
    public func configure(with color: UIColor) {
        colorView.backgroundColor = color
    }
    // MARK: - override methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(colorView.prepareLayout())
        colorView.pin(view: self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.layer.cornerRadius = frame.height / 2
        colorView.layer.borderWidth = 1
        colorView.layer.borderColor = UIColor.lightGray.cgColor
    }
}

