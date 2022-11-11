// InteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Конфигурация интерактивного перехода
final class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Constants

    private enum Constants {
        static let pullPercent = 0.33
    }

    // MARK: - Public properties

    var isStarted = false
    var isFinished = false

    // MARK: - Visual elements

    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanAction(_:)))
            recognizer.edges = .left
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }

    // MARK: - Private methods

    @objc private func handlePanAction(_ gesture: UIScreenEdgePanGestureRecognizer) {
        switch gesture.state {
        case .began:
            isStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = gesture.translation(in: gesture.view)
            let relativeTranslation = translation.x / (gesture.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            isFinished = progress > Constants.pullPercent
            update(progress)
        case .ended:
            isStarted = false
            guard isFinished else { return cancel() }
            finish()
        case .cancelled:
            isStarted = false
            cancel()
        default:
            return
        }
    }
}
