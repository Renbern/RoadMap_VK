// PopAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Анимация перехода назад
final class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Public methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)

        destination.view.frame = source.view.frame

        let translation = CGAffineTransform(
            translationX: -(source.view.frame.width / 2 + source.view.frame.height / 2),
            y: -source.view.frame.width / 2
        )

        let rotation = CGAffineTransform(rotationAngle: 90 * .pi / 180)

        destination.view.transform = rotation.concatenating(translation)

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.4,
                    animations: {
                        let translation = CGAffineTransform(
                            translationX:
                            source.view.frame.width / 2,
                            y: 0
                        )
                        let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                        source.view.transform = translation.concatenating(scale)
                    }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 0.4,
                    relativeDuration: 0.4,
                    animations: {
                        source.view.transform = CGAffineTransform(
                            translationX:
                            source.view.frame.width,
                            y: 0
                        )
                    }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 0.6,
                    relativeDuration: 0.4,
                    animations: {
                        destination.view.transform = .identity
                    }
                )
            }, completion: { finished in
                if finished, !transitionContext.transitionWasCancelled {
                    source.removeFromParent()
                } else if transitionContext.transitionWasCancelled {
                    destination.view.transform = .identity
                }
                transitionContext
                    .completeTransition(
                        finished &&
                            !transitionContext.transitionWasCancelled
                    )
            }
        )
    }
}
