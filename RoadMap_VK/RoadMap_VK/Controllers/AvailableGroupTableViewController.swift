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

    private var groups: [Group] = [
        Group(
            name: Constants.GroupNames.sport,
            groupImageName: Constants.GroupsImageNames.sportImageName
        ),
        Group(
            name: Constants.GroupNames.pikabu,
            groupImageName: Constants.GroupsImageNames.pikabuImageName
        )
    ]

    private(set) var searchedGroups: [Group] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods

    private func setupUI() {
        setupSearchbar()
    }

    private func setupSearchbar() {
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
        cell.refreshPhoto(searchedGroups[indexPath.row])
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension AvailableGroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedGroups = searchText.isEmpty ? groups : groups.filter { $0.name.contains(searchText) }
        tableView.reloadData()
    }
}
