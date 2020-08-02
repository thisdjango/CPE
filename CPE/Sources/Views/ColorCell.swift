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
        colorView.pin()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        heightAnchor.constraint(equalToConstant: 20).isActive = true
        widthAnchor.constraint(equalToConstant: 20).isActive = true
        colorView.layer.cornerRadius = frame.height / 2
        colorView.layer.borderWidth = 3
        colorView.layer.borderColor = UIColor.white.cgColor
    }
}

extension UIView {
    func prepareLayout() -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    func pin() {
        if let superview = superview {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
}

