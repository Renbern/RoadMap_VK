// InteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Конфигурация интерактивного перехода
final class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Public properties

    var hasStarted = false
    var shouldFinish = false
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
            hasStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = gesture.translation(in: gesture.view)
            let relativeTranslation = translation.x / (gesture.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            shouldFinish = progress > 0.33
            update(progress)
        case .ended:
            hasStarted = false
            guard shouldFinish else { return cancel() }
            finish()
        case .cancelled:
            hasStarted = false
            cancel()
        default:
            return
        }
    }
}
