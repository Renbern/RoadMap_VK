// LoadingDotsView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Представление точек загрузки
final class LoadingDotsView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let whiteColor = "VKWhite"
        static let opacityKeyPath = "opacity"
    }

    // MARK: - Private properties

    private var stackView: UIStackView?
    private lazy var dots: [UIView] = []

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupStackView()
    }

    // MARK: - Public methods

    override func layoutSubviews() {
        stackView?.frame = bounds
    }

    // MARK: - Private methods

    private func setupView() {
        for _ in 0 ..< 3 {
            let view = UIView()
            view.backgroundColor = UIColor(named: Constants.whiteColor)
            view.heightAnchor.constraint(equalToConstant: bounds.height - 5).isActive = true
            view.layer.cornerRadius = (bounds.height - 5) / 2
            view.alpha = 0.5
            view.layer.masksToBounds = true
            dots.append(view)
        }
    }

    private func setupStackView() {
        stackView = UIStackView(arrangedSubviews: dots)
        guard let stackView = stackView else { return }
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        addSubview(stackView)
        animateDots()
    }

    private func animateDots() {
        var delay = 0.0
        dots.forEach { dot in
            delay += 0.3
            self.makeOpacity(for: dot, delay: delay)
        }
    }

    private func makeOpacity(for view: UIView, delay: Double) {
        let animation = CABasicAnimation(keyPath: Constants.opacityKeyPath)
        animation.fromValue = 1
        animation.toValue = 0.5
        animation.duration = 0.7
        animation.beginTime = CACurrentMediaTime() + delay
        animation.repeatCount = .infinity
        animation.fillMode = .backwards
        animation.autoreverses = true
        view.layer.add(animation, forKey: nil)
    }
}
