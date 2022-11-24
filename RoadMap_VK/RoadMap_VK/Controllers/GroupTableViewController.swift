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

    private lazy var service = VKService()
    private var groups: [ItemGroup] = []

    private var searchedGroups: [ItemGroup] = []

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
        if searchedGroups.contains(where: { $0.groupName == searchedGroups[indexPath.row].groupName }) {
            searchedGroups = groups
            tableView.reloadData()
        }
    }

    // MARK: - Private methods

    private func setupUI() {
        searchBar.delegate = self
        service.sendGroupRequest(urlString: RequestType.groups.urlString) { [weak self] groups in
            self?.searchedGroups = groups
            self?.groups = groups
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
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
        cell.configureGroup(group)
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
        searchedGroups = searchText.isEmpty ? groups : searchedGroups
            .filter { $0.groupName.contains(searchText) }
        tableView.reloadData()
    }
}
