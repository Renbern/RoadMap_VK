// TextPostTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка текста секции поста
final class TextPostTableViewCell: UITableViewCell, PostConfigurable {
    // MARK: - Private visual elements

    @IBOutlet var postTextView: UITextView!

    // MARK: - Private properties

    private let instets: CGFloat = 10

    // MARK: - Public methods

    func configure(post: Post, photoCacheService: PhotoCacheService) {
        postTextView.text = post.text
        postTextView.sizeToFit()
        setupTextContent()
    }

    // MARK: - Private methods

    private func getLabelSize(text: String, font: UIFont) -> CGSize {
        let maxWidth = bounds.width - instets * 2
        let textBlock = CGSize(
            width: maxWidth,
            height:
            CGFloat.greatestFiniteMagnitude
        )
        let rect = text.boundingRect(
            with: textBlock,
            options:
            .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }

    private func setupTextContent() {
        let textContentSize = getLabelSize(
            text: postTextView.text,
            font: postTextView.font ?? UIFont()
        )
        let textContentX = (bounds.width - textContentSize.width) / 2
        let textContentOrigin = CGPoint(x: textContentX, y: instets)
        postTextView.frame = CGRect(
            origin: textContentOrigin,
            size: textContentSize
        )
    }
}
