// PushAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимация перехода вперед
final class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Constants

    private enum Constants {
        static let rotationAngle: CGFloat = -90
        static let translationXPoints: CGFloat = -200
    }

    // MARK: - Public methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame

        let translation = CGAffineTransform(
            translationX: source.view.frame.height / 2,
            y: -source.view.frame.width / 2
        )
        let rotation = CGAffineTransform(rotationAngle: Constants.rotationAngle)
        destination.view.transform = rotation.concatenating(translation)

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.75
                ) {
                    let transform = CGAffineTransform(
                        translationX: Constants.translationXPoints,
                        y: 0
                    )
                    let scale = CGAffineTransform(
                        scaleX: 0.8,
                        y: 0.8
                    )

                    source.view.transform = transform.concatenating(scale)
                }

                UIView.addKeyframe(
                    withRelativeStartTime: 0.2,
                    relativeDuration: 0.4
                ) {
                    let translation = CGAffineTransform(
                        translationX: source.view.frame.width / 2,
                        y: 0
                    )
                    let scale = CGAffineTransform(
                        scaleX: 1.2,
                        y: 1.2
                    )
                    destination.view.transform = translation.concatenating(scale)
                }

                UIView.addKeyframe(
                    withRelativeStartTime: 0.6,
                    relativeDuration: 0.4
                ) {
                    destination.view.transform = .identity
                }
            }, completion: { result in
                if result, !transitionContext.transitionWasCancelled {
                    source.view.transform = .identity
                }
                transitionContext.completeTransition(result && !transitionContext.transitionWasCancelled)
            }
        )
    }
}
