// FriendsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Ячейка таблицы друзей
final class FriendsTableViewCell: UITableViewCell {
    // MARK: - Private IBOutlets

    @IBOutlet private var friendPhotoImageView: UIImageView!
    @IBOutlet private var friendView: FriendView!
    @IBOutlet private var friendNameLabel: UILabel!

    // MARK: - Public properties

    var friendPhotoImageName: String?
    var friendPhotosNames: [String] = []

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Public methods

    func refreshPhoto(_ model: User) {
        friendPhotoImageView.image = UIImage(named: model.friendPhotoImageName)
        friendNameLabel.text = model.name
        friendPhotoImageName = model.friendPhotoImageName
        friendPhotosNames = model.photoNames
    }

    // MARK: - Private methods

    @objc private func animatePhotoTapAction() {
        let bounds = friendPhotoImageView.bounds
        UIView.animate(
            withDuration: 0.8,
            delay: 0.0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.7,
            options: [.autoreverse],
            animations: {
                self.friendPhotoImageView.bounds = CGRect(
                    x: bounds.origin.x,
                    y: bounds.origin.y,
                    width: bounds.width + 3,
                    height: bounds.height + 3
                )
            }
        )
    }

    private func setupUI() {
        friendView.configureShadow()
        setupPhotoTapAnimation()
    }

    private func setupPhotoTapAnimation() {
        let photoGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animatePhotoTapAction))
        friendPhotoImageView.isUserInteractionEnabled = true
        friendPhotoImageView.addGestureRecognizer(photoGestureRecognizer)
    }
}
