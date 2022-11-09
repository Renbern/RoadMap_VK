// GradientView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Представление градиента
@IBDesignable class GradientView: UIView {
    // MARK: - Public properties

    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }

    // MARK: - Private properties

    private var gradientLayer: CAGradientLayer {
        layer as? CAGradientLayer ?? .init()
    }

    @IBInspectable private var startColor: UIColor = .white {
        didSet {
            updateColors()
        }
    }

    @IBInspectable private var endColor: UIColor = .black {
        didSet {
            updateColors()
        }
    }

    @IBInspectable private var startLocation: CGFloat = 0 {
        didSet {
            updateLocations()
        }
    }

    @IBInspectable private var endLocation: CGFloat = 0 {
        didSet {
            updateLocations()
        }
    }

    @IBInspectable private var startPoint: CGPoint = .zero {
        didSet {
            updateStartPoint()
        }
    }

    @IBInspectable private var endPoint: CGPoint = .init(x: 0, y: 1) {
        didSet {
            updateEndPoint()
        }
    }

    // MARK: - Private methods

    private func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }

    private func updateStartPoint() {
        gradientLayer.startPoint = startPoint
    }

    private func updateEndPoint() {
        gradientLayer.endPoint = endPoint
    }

    private func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
}
