// AvailableGroupTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран групп доступных для подписки
final class AvailableGroupTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        enum GroupNames {
            static let sport = "Бег с препятствиями"
            static let pikabu = "Pikabu"
        }

        enum GroupsImageNames {
            static let sportImageName = "sport"
            static let pikabuImageName = "pikabu"
        }

        static let availableGroupIdentifier = "availableGroupCell"
    }

    // MARK: - Private IBOutlets

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Private properties

    private lazy var service = VKService()
    private var groups: [ItemGroup] = [
    ]

    private(set) var searchedGroups: [ItemGroup] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods

    private func setupUI() {
        setupSearchBar()
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        searchedGroups = groups
    }
}

// MARK: - UITableViewDataSource

extension AvailableGroupTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.availableGroupIdentifier,
            for: indexPath
        ) as? GroupTableViewCell else { return UITableViewCell() }
        cell.configureGroup(searchedGroups[indexPath.row])
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension AvailableGroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        service
            .sendSearchGroupRequest(urlString: searchText) { groups in
                self.searchedGroups = groups
                self.tableView.reloadData()
            }
    }
}
