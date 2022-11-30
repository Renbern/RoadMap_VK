// PhotoView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Представление фото пользователя
final class PhotoView: UIView {
    // MARK: - Constants

    private enum Constants {
        static let leftSwipeTranslationDistance = -500
        static let rightSwipeTranslationDistance = 500
        static let friendImageViewAnimationWidth = 0.6
        static let friendImageViewAnimationHeight = 0.6
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var currentNumberLabel: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    // MARK: - Public properties

    var photos: [String] = []
    var navController: UINavigationController?

    // MARK: - Private properties

    private var index = Int()

    // MARK: - Initializers

    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.startAnimating()
    }

    // MARK: - Public methods

    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func updatePhoto(count: Int) {
        currentNumberLabel.text = "1 / \(count)"
        guard let url = photos.last else { return }
        friendImageView.load(url: url)
    }

    func createSwipeGestureRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureAction))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureAction))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        addGestureRecognizer(swipeLeft)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureAction))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.right
        addGestureRecognizer(swipeDown)
    }

    // MARK: - Private IBActions

    @objc private func respondToSwipeGestureAction(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                swipe(translationX: Constants.leftSwipeTranslationDistance, increaseIndex: 1)
            case UISwipeGestureRecognizer.Direction.right:
                swipe(translationX: Constants.rightSwipeTranslationDistance, increaseIndex: -1)
            default:
                break
            }
        }
    }

    // MARK: - Private methods

    private func swipe(translationX: Int, increaseIndex: Int) {
        index += increaseIndex
        guard index < photos.count, index >= 0 else {
            index -= increaseIndex
            return
        }
        UIView.animate(
            withDuration: 2,
            animations: {
                let translation = CGAffineTransform(translationX: CGFloat(translationX), y: 0)
                self.friendImageView.transform = translation
                    .concatenating(CGAffineTransform(
                        scaleX: Constants.friendImageViewAnimationWidth,
                        y: Constants.friendImageViewAnimationHeight
                    ))
                self.friendImageView.layer.opacity = 0.2
            }, completion: { _ in
                self.friendImageView.layer.opacity = 1
                self.friendImageView.transform = .identity
                let urlPhoto = self.photos[self.index]
                self.friendImageView.load(url: urlPhoto)
                self.currentNumberLabel.text = "\(self.index + 1) / \(self.photos.count)"
            }
        )
    }
}
