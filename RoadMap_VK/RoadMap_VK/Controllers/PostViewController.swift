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
        static let textContentCellId = "TextPostTableViewCell"
        static let imageContentCellId = "ImagePostTableViewCell"
        static let footerCellId = "PostFooterTableViewCell"
        static let VKBlueColor = "VKBlue"
        static let refreshControlText = "Загружаем хорошие новости..."
        static let emptyString = ""
        enum PostCellType: Int, CaseIterable {
            case header
            case textContent
            case imageContent
            case footer
        }
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var tableView: UITableView!

    // MARK: - Private properties

    private let vkAPIService = VKAPIService()
    private let photoCacheService = PhotoCacheService()
    private let textViewContent = TextPostTableViewCell()

    private var nextFrom = Constants.emptyString
    private var isLoading = false
    private var news: [Post] = []
    private var mostFreshDate: Int?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Private methods

    @objc private func refreshNewsAction() {
        fetchNews()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.delegate = self
        fetchNews()
        setupRefreshControl()
    }

    private func setupRefreshControl() {
        guard let colorTitle = UIColor(named: Constants.VKBlueColor) else { return }
        let refreshControlAttributes: [NSAttributedString.Key: UIColor] =
            [.foregroundColor: colorTitle]
        textViewContent.refreshControl.attributedTitle = NSAttributedString(
            string: Constants.refreshControlText,
            attributes: refreshControlAttributes
        )
        textViewContent.refreshControl.tintColor = colorTitle
        textViewContent.refreshControl.addTarget(self, action: #selector(refreshNewsAction), for: .valueChanged)
        tableView.addSubview(textViewContent.refreshControl)
    }

    private func fetchNews() {
        if let firstItem = news.first {
            mostFreshDate = Int(firstItem.date) + 1
        }
        vkAPIService.fetchNews(startTime: mostFreshDate, startFrom: nextFrom) { [weak self] result in
            guard let self = self else { return }
            self.textViewContent.refreshControl.endRefreshing()
            switch result {
            case let .success(data):
                self.newsFilter(newsFeedResponse: data)
                self.tableView.reloadData()
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
            self.news = newsFeedResponse.news + self.news
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
        let cellType = Constants.PostCellType(rawValue: indexPath.row) ?? .textContent
        var cellIdentifier = Constants.emptyString
        switch cellType {
        case .header:
            cellIdentifier = Constants.headerCellId
        case .textContent:
            cellIdentifier = Constants.textContentCellId
        case .imageContent:
            cellIdentifier = Constants.imageContentCellId
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

// MARK: - UITableViewDelegate

extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            let tableWidth = tableView.bounds.width
            guard let news = news[indexPath.section].attachments?.last?.photo?.photos.first?.aspectRatio
            else { return CGFloat() }
            let cellHeight = tableWidth * news
            return cellHeight
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension PostViewController: UITableViewDataSourcePrefetching {
    func tableView(
        _ tableView: UITableView,
        prefetchRowsAt indexPaths:
        [IndexPath]
    ) {
        guard let maxSection = indexPaths.map(\.section).max(),
              maxSection > news.count - 3,
              !isLoading
        else { return }
        isLoading = true
        vkAPIService.fetchNews(startTime: mostFreshDate, startFrom: nextFrom) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                let indexSet = IndexSet(
                    integersIn: self.news.count ..<
                        self.news.count + data.news.count
                )
                self.news.append(contentsOf: self.news)
                self.tableView.insertSections(indexSet, with: .automatic)
                self.isLoading = false
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
