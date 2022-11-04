// LikeControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Контрол лайка
final class LikeControl: UIControl {
    // MARK: - Constants

    private enum Constants {
        static let heart = "heart"
    }

    // MARK: - IBOutlets

    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var likeNumberLabel: UILabel!

    // MARK: - Private properties

    private var isLiked = false
    private var like = 0

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - IBActions

    @IBAction private func likeAction() {
        if isLiked == false {
            likeNumberLabel.text = String(like + 1)
            isLiked = true
        } else {
            likeNumberLabel.text = String(like + 0)
            isLiked = false
        }
    }

    // MARK: - Private methods

    private func setupUI() {
        likeButton.setImage(UIImage(systemName: Constants.heart), for: .normal)
        likeButton.tintColor = .systemRed
        likeNumberLabel.text = String(like)
    }
}
