// GroupTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран групп пользователя
final class GroupTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        enum GroupNames {
            static let hearedVologda = "Подслушано RoadMap"
            static let iOSDevelopersVologda = "Айосеры Вологодчины"
        }

        enum GroupsImageNames {
            static let hearedVologdaImageName = "heared"
            static let iOSDevelopersVologdaImageName = "swift"
        }

        enum Identifiers {
            static let addGroupSegueId = "groupsCell"
            static let groupUnwindId = "groupUnwind"
        }
    }

    // MARK: - Private properties

    var groups: [Group] = [
        Group(
            name: Constants.GroupNames.hearedVologda,
            groupImageName: Constants.GroupsImageNames.hearedVologdaImageName
        ),
        Group(
            name: Constants.GroupNames.iOSDevelopersVologda,
            groupImageName: Constants.GroupsImageNames.iOSDevelopersVologdaImageName
        )
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions

    @IBAction private func addGroupAction(segue: UIStoryboardSegue) {
        if segue.identifier == Constants.Identifiers.groupUnwindId {
            guard let userGroupsController = segue.source as? AvailableGroupTableViewController
            else { return }
            if let indexPath = userGroupsController.tableView.indexPathForSelectedRow {
                let group = userGroupsController.groups[indexPath.row]
                if groups.contains(where: { $0.name == groups[indexPath.row].name }) {
                    groups.append(group)
                    tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension GroupTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifiers.addGroupSegueId,
            for: indexPath
        ) as? GroupTableViewCell else { return UITableViewCell() }
        cell.refreshPhoto(groups[indexPath.row])
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
