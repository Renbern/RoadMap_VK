// PostViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import RealmSwift
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

    private let vkAPIService = VKAPIService()
    private let photoCacheService = PhotoCacheService()
    private var news: [Post] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Private methods

    private func setupTableView() {
        tableView.dataSource = self
        fetchNews()
    }

    private func fetchNews() {
        vkAPIService.fetchNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.newsFilter(newsFeedResponse: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func newsFilter(newsFeedResponse: PostResponse) {
        newsFeedResponse.news.forEach { news in
            guard let group = newsFeedResponse.groups.filter({ group in
                group.id == news.sourceId * -1
            }).first else { return }
            if news.sourceId < 0 {
                news.authorName = group.groupName
                news.avatarPath = group.groupPhotoImageName
            } else {
                guard let user = newsFeedResponse.friends.filter({ user in
                    user.userId == news.sourceId
                }).first else { return }
                news.authorName = "\(user.firstName) \(user.lastName)"
                news.avatarPath = user.friendPhotoImageName
            }
        }
        DispatchQueue.main.async {
            self.news = newsFeedResponse.news
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PostViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.PostCellType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = news[indexPath.section]
        let cellType = Constants.PostCellType(rawValue: indexPath.row) ?? .content
        var cellIdentifier = ""
        switch cellType {
        case .header:
            cellIdentifier = Constants.headerCellId
        case .content:
            cellIdentifier = Constants.textPostCellId
        case .footer:
            cellIdentifier = Constants.footerCellId
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
        ) as? PostCell
        else {
            return UITableViewCell()
        }
        cell.configure(post: news, photoCacheService: photoCacheService)
        return cell
    }
}
