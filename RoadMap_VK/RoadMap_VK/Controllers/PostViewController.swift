// PostViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран нвостей
final class PostViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let headerCellId = "PostHeaderTableViewCell"
        static let textPostCellId = "TextPostTableViewCell"
        static let imagePostCellId = "ImagePostTableViewCell"
        static let footerCellId = "PostFooterTableViewCell"
        enum PostCellType: Int, CaseIterable {
            case header
            case content
            case footer
        }
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var tableView: UITableView!

    // MARK: - Private properties

    private let posts = PostItem.fake

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Private methods

    private func setupTableView() {
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PostViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.PostCellType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = posts[indexPath.section]
        let cellType = Constants.PostCellType(rawValue: indexPath.row) ?? .content
        var cellIdentifier = ""
        switch cellType {
        case .header:
            cellIdentifier = Constants.headerCellId
        case .content:
            switch item.type {
            case .text:
                cellIdentifier = Constants.textPostCellId
            case .image:
                cellIdentifier = Constants.imagePostCellId
            }

        case .footer:
            cellIdentifier = Constants.footerCellId
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
        ) as? PostCell else { return UITableViewCell() }
        cell.configure(item: item)
        return cell
    }
}
