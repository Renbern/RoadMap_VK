// PhotoView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Представление фото пользователя
final class PhotoView: UIView {
    // MARK: - Constants

    private enum Constants {
        enum Photos {
            static let goblinPhoto = "goblin"
            static let iron1Photo = "iron1"
            static let iron2Photo = "iron2"
            static let iron3Photo = "iron3"
            static let iron4Photo = "iron4"
            static let tonyPhoto = "tony"
        }
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var currentNumberLabel: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    // MARK: - Public properties

    var photoImages: [UIImage] = []
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
        friendImageView.image = photoImages.first
    }

    func createSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        addGestureRecognizer(swipeLeft)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.right
        addGestureRecognizer(swipeDown)
    }

    // MARK: - Private IBActions

    @objc private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                swipe(translationX: -500, increaseIndex: 1)
            case UISwipeGestureRecognizer.Direction.right:
                swipe(translationX: 500, increaseIndex: -1)
            case UISwipeGestureRecognizer.Direction.down:
                swipeDown()
            default:
                break
            }
        }
    }

    // MARK: - Private methods

    private func swipe(translationX: Int, increaseIndex: Int) {
        index += increaseIndex
        guard index < photoImages.count, index >= 0 else {
            index -= increaseIndex
            return
        }
        UIView.animate(
            withDuration: 1,
            animations: {
                let translation = CGAffineTransform(translationX: CGFloat(translationX), y: 0)
                self.friendImageView.transform = translation
                    .concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                self.friendImageView.layer.opacity = 0.2
            }, completion: { _ in
                self.friendImageView.layer.opacity = 1
                self.friendImageView.transform = .identity
                self.friendImageView.image = self.photoImages[self.index]
                self.currentNumberLabel.text = "\(self.index + 1) / \(self.photoImages.count)"
            }
        )
    }

    private func swipeDown() {
        UIView.animate(
            withDuration: 0.7,
            animations: {
                let translation = CGAffineTransform(translationX: 0, y: 1500)
                self.friendImageView.transform = translation
                    .concatenating(CGAffineTransform(scaleX: 0.3, y: 0.3))
            },
            completion: { _ in
                self.navController?.popViewController(animated: true)
            }
        )
    }
}
