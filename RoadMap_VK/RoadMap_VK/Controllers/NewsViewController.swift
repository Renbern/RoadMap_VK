// NewsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран нвостей
final class NewsViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let postCell = "postCell"
        static let author = "Nicolas Cage"
        static let postText = "Test post"
        static let postImageName = "space"
        static let searchQuery = "Music"
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var tableView: UITableView!

    // MARK: - Private properties

    private lazy var service = VKAPIService()
    private var posts: [Url] = []

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

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.postCell,
            for: indexPath
        ) as? NewsTableViewCell
        else {
            return UITableViewCell()
        }
        return cell
    }
}
