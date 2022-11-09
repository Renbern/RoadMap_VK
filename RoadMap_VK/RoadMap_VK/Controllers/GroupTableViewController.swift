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

    // MARK: - Private IBOutlets

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Private properties

    private var groups: [Group] = [
        Group(
            name: Constants.GroupNames.hearedVologda,
            groupImageName: Constants.GroupsImageNames.hearedVologdaImageName
        ),
        Group(
            name: Constants.GroupNames.iOSDevelopersVologda,
            groupImageName: Constants.GroupsImageNames.iOSDevelopersVologdaImageName
        )
    ]

    private var searchedGroups: [Group] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private IBActions

    @IBAction private func addGroupAction(segue: UIStoryboardSegue) {
        guard
            segue.identifier == Constants.Identifiers.groupUnwindId,
            let userGroupsController = segue.source as? AvailableGroupTableViewController,
            let indexPath = userGroupsController.tableView.indexPathForSelectedRow
        else { return }
        let group = userGroupsController.searchedGroups[indexPath.row]
        if searchedGroups.contains(where: { $0.name == searchedGroups[indexPath.row].name }) {
            searchedGroups.append(group)
            tableView.reloadData()
        }
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

extension GroupTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifiers.addGroupSegueId,
            for: indexPath
        ) as? GroupTableViewCell else { return UITableViewCell() }
        let group = searchedGroups[indexPath.row]
        cell.configure(group)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            searchedGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

// MARK: - UISearchBarDelegate

extension GroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedGroups = searchText.isEmpty ? groups : groups.filter { $0.name.contains(searchText) }
        tableView.reloadData()
    }
}
