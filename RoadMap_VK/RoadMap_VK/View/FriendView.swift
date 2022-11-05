// FriendView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кастомная вью, с тенью
@IBDesignable final class FriendView: UIView {
    override class var layerClass: AnyClass {
        CAShapeLayer.self
    }

    // MARK: - Private properties

    @IBInspectable private var shadowColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable private var borderWidth: CGFloat = 0.3 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowOpacity: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowRadius: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: - Private method

    func configureShadow() {
        layer.borderWidth = borderWidth
        layer.cornerRadius = 40
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = Float(shadowOpacity)
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = .zero
    }
}
