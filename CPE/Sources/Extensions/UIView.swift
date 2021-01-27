//
//  UIView.swift
//  CPE
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//


import UIKit

extension UIView {
    
    func prepareLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func pinEdgesToSuperviewEdges(withOffset offset: CGFloat) {
        self.pinEdgesToSuperviewEdges(top: offset, left: offset, right: offset, bottom: offset)
    }
    func centerAtSuperview() {
        guard let superview = superview else {
            fatalError("There is no superview")
        }
        centerYAnchor ^= superview.centerYAnchor
        centerXAnchor ^= superview.centerXAnchor
    }
    
    func pinEdgesToSuperviewEdges(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("There is no superview")
        }
        leftAnchor ^= superview.leftAnchor + left
        rightAnchor ^= superview.rightAnchor - right
        topAnchor ^= superview.topAnchor + top
        bottomAnchor ^= superview.bottomAnchor - bottom
    }
    
    enum PinnedSide {
        case top
        case left
        case right
        case bottom
    }
    
    func pinEdgesToSuperviewEdges(excluding side: PinnedSide) {
        switch side {
        case .top:
            self.pinToSuperview([.left, .right, .bottom])
        case .left:
            self.pinToSuperview([.top, .right, .bottom])
        case .right:
            self.pinToSuperview([.top, .left, .bottom])
        case .bottom:
            self.pinToSuperview([.top, .left, .right])
        }
        
    }
    
    func pinToSuperview(_ sides: [PinnedSide]) {
        guard let superview = superview, !sides.isEmpty else {
            fatalError("There is no superview or sides")
        }
        
        sides.forEach { side in
            switch side {
            case .top:
                topAnchor ^= superview.topAnchor
            case .right:
                rightAnchor ^= superview.rightAnchor
            case .left:
                leftAnchor ^= superview.leftAnchor
            case .bottom:
                bottomAnchor ^= superview.bottomAnchor
            }
        }
    }
    
    func pin(to view: UIView, top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) {
        pin(to: view, edgesInsets: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }
    
    func pin(to view: UIView, edgesInsets: UIEdgeInsets) {
        if view.translatesAutoresizingMaskIntoConstraints != false &&
            self.translatesAutoresizingMaskIntoConstraints != false {
            fatalError("Pin to the view with translatesAutoresizingMaskIntoConstraints = true")
        }
        topAnchor ^= view.topAnchor + edgesInsets.top
        rightAnchor ^= view.rightAnchor - edgesInsets.right
        leftAnchor ^= view.leftAnchor + edgesInsets.left
        bottomAnchor ^= view.bottomAnchor - edgesInsets.bottom
    }
    
    func pin(as view: UIView, using sides: [PinnedSide]) {
        if view.translatesAutoresizingMaskIntoConstraints != false &&
            self.translatesAutoresizingMaskIntoConstraints != false {
            fatalError("Pin to the view with translatesAutoresizingMaskIntoConstraints = true")
        }
        sides.forEach { side in
            switch side {
            case .top:
                topAnchor ^= view.topAnchor
            case .right:
                rightAnchor ^= view.rightAnchor
            case .left:
                leftAnchor ^= view.leftAnchor
            case .bottom:
                bottomAnchor ^= view.bottomAnchor
            }
        }
    }
}

struct ConstraintAttribute<T: AnyObject> {
    let anchor: NSLayoutAnchor<T>
    let const: CGFloat
}

struct LayoutGuideAttribute {
    let guide: UILayoutSupport
    let const: CGFloat
}

func + <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    ConstraintAttribute(anchor: lhs, const: rhs)
}

func + (lhs: UILayoutSupport, rhs: CGFloat) -> LayoutGuideAttribute {
    LayoutGuideAttribute(guide: lhs, const: rhs)
}

func - <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    ConstraintAttribute(anchor: lhs, const: -rhs)
}

func - (lhs: UILayoutSupport, rhs: CGFloat) -> LayoutGuideAttribute {
    LayoutGuideAttribute(guide: lhs, const: -rhs)
}

// ^= is used instead of == because Swift can't overload == for NSObject subclass
@discardableResult
func ^= (lhs: NSLayoutYAxisAnchor, rhs: UILayoutSupport) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs.bottomAnchor)
    constraint.isActive = true
    return constraint
}

@discardableResult
func ^= <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs)
    constraint.isActive = true
    return constraint
}

@discardableResult
func <= <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(lessThanOrEqualTo: rhs)
    constraint.isActive = true
    return constraint
}

@discardableResult
func >= <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(greaterThanOrEqualTo: rhs)
    constraint.isActive = true
    return constraint
}

@discardableResult
func ^= <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs.anchor, constant: rhs.const)
    constraint.isActive = true
    return constraint
}

@discardableResult
func ^= (lhs: NSLayoutYAxisAnchor, rhs: LayoutGuideAttribute) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs.guide.bottomAnchor, constant: rhs.const)
    constraint.isActive = true
    return constraint
}

@discardableResult
func ^= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalToConstant: rhs)
    constraint.isActive = true
    return constraint
}

@discardableResult
func <= <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.const)
    constraint.isActive = true
    return constraint
}

@discardableResult
func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    let constraint = lhs.constraint(lessThanOrEqualToConstant: rhs)
    constraint.isActive = true
    return constraint
}

@discardableResult
func >= <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.const)
    constraint.isActive = true
    return constraint
}

@discardableResult
func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    let constraint = lhs.constraint(greaterThanOrEqualToConstant: rhs)
    constraint.isActive = true
    return constraint
}


extension UILabel {
    func textObjectToLabel(textObject: TextObject) {
        font = textObject.font
        textColor = textObject.color
        text = textObject.string
        alpha = textObject.transparent
    }
}

extension UILabel {
    @objc func scalePiece(_ gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            transform = (transform.scaledBy(
                                                    x: gestureRecognizer.scale,
                                                    y: gestureRecognizer.scale))
            sizeToFit()
            gestureRecognizer.scale = 1.0
       }
    }
    @objc func rotate(_ gestureRecognizer: UIRotationGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            transform = CGAffineTransform(rotationAngle: gestureRecognizer.rotation)
            sizeToFit()
        }
    }
}
