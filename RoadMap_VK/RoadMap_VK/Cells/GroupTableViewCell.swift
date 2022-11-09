// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка группы
final class GroupTableViewCell: UITableViewCell {
    // MARK: - Private visual elements

    @IBOutlet private var groupPhotoImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public properties

    var groupPhotoImageName: String?

    // MARK: - Public methods

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func refreshPhoto(_ model: Group) {
        groupPhotoImageView.image = UIImage(named: model.groupImageName)
        groupNameLabel.text = model.name
        groupPhotoImageName = model.groupImageName
    }

    // MARK: - Private methods

    @objc private func animatePhotoTapAction() {
        let bounds = groupPhotoImageView.bounds
        UIView.animate(
            withDuration: 0.8,
            delay: 0.0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.5,
            options: [.autoreverse],
            animations: {
                self.groupPhotoImageView.bounds = CGRect(
                    x: bounds.origin.x,
                    y: bounds.origin.y,
                    width: bounds.width + 3,
                    height: bounds.height + 3
                )
            }
        )
    }

    private func setupUI() {
        setupPhotoTapAnimation()
    }

    private func setupPhotoTapAnimation() {
        let photoGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animatePhotoTapAction))
        groupPhotoImageView.isUserInteractionEnabled = true
        groupPhotoImageView.addGestureRecognizer(photoGestureRecognizer)
    }
}
