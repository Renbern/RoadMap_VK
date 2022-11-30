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
    var photos: [String] = []

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Public methods

    func refreshFriends(_ friend: FriendsItem) {
        let url = friend.friendPhotoImageName
        friendPhotoImageView.load(url: url)
        friendNameLabel.text = "\(friend.firstName) \(friend.lastName)"
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
