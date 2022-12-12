// PostLikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контрол лайков
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
    @IBOutlet private var likeCountLabel: UILabel!
    @IBOutlet private var viewCountLabel: UILabel!

    // MARK: - Private properties

    private var likeCount = 0
    private var likeControlImageName = ""
    private var likeControlButtonTitle = ""

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Private IBActions

    @IBAction private func likeAction() {
        isSelected = !isSelected
        likeCount = isSelected ? likeCount + 1 : likeCount - 1
        likeCountLabel.text = String(likeCount)
        likeControlImageName = isSelected ? Constants.filledHeart : Constants.heart
        likeButton.setImage(UIImage(systemName: likeControlImageName), for: .normal)
        likeControlButtonTitle = isSelected ? Constants.unlikeText : Constants.likeText
        likeButton.setTitle(likeControlButtonTitle, for: .normal)
        setupLikeAnimation()
    }

    // MARK: - Private methods

    private func setupLikeAnimation() {
        UIView.transition(
            with: likeCountLabel,
            duration: 1.0,
            options: .transitionFlipFromRight,
            animations: nil
        )
    }
}

// MARK: - PostConfigurable

extension PostLikeControl: PostConfigurable {
    func configure(post: Post, photoCacheService: PhotoCacheService) {
        likeCountLabel?.text = "\(post.likes.count)"
        likeCount = post.likes.count
        viewCountLabel.text = "\(post.views.count)"
    }
}
