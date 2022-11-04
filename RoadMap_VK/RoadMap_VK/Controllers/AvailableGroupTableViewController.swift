// AvailableGroupTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран групп доступных для подписки
final class AvailableGroupTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        enum GroupNames {
            static let sport = "Cпорт"
            static let pikabu = "Pikabu"
        }

        enum GroupsImageNames {
            static let sportImageName = "sport"
            static let pikabuImageName = "pikabu"
        }

        static let availableGroupIdentifier = "availableGroupCell"
    }

    // MARK: - Private properties

    var groups: [Group] = [
        Group(
            name: Constants.GroupNames.sport,
            groupImageName: Constants.GroupsImageNames.sportImageName
        ),
        Group(
            name: Constants.GroupNames.pikabu,
            groupImageName: Constants.GroupsImageNames.pikabuImageName
        )
    ]
}

// MARK: - UITableViewDataSource

extension AvailableGroupTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.availableGroupIdentifier,
            for: indexPath
        ) as? AvailableGroupTableViewCell else { return UITableViewCell() }
        cell.refreshPhoto(groups[indexPath.row])
        return cell
    }
}
