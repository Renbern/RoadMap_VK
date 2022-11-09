// PostLikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контрол лайков поста
final class PostLikeControl: UIControl {
    // MARK: - Constants

    private enum Constants {
        static let heart = "heart"
        static let filledHeart = "heart.fill"
        static let likeText = "Нравится"
        static let unlikeText = "Не нравится"
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var likeNumberLabel: UILabel!

    // MARK: - Private properties

    private var isLiked = false
    private var likeCount = 0

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private IBActions

    @IBAction private func likeAction() {
        if isLiked == false {
            likeNumberLabel.text = String(likeCount + 1)
            setupLikeAnimation()
            likeButton.setImage(UIImage(systemName: Constants.filledHeart), for: .normal)
            likeButton.setTitle(Constants.unlikeText, for: .normal)
            isLiked = true
        } else {
            likeNumberLabel.text = String(likeCount + 0)
            setupLikeAnimation()
            likeButton.setImage(UIImage(systemName: Constants.heart), for: .normal)
            likeButton.setTitle(Constants.likeText, for: .normal)
            isLiked = false
        }
    }

    // MARK: - Private methods

    private func setupUI() {
        likeNumberLabel.text = String(likeCount)
    }

    private func setupLikeAnimation() {
        UIView.transition(
            with: likeNumberLabel,
            duration: 1.0,
            options: .transitionFlipFromRight,
            animations: nil
        )
    }
}
