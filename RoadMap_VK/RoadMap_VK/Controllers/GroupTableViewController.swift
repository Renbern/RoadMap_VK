// GroupTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
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

    private let vkAPIService = VKAPIService()
    private var groupToken: NotificationToken?
    private var groups: Results<ItemGroup>?
    private var searchedGroups: Results<ItemGroup>?

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
    }

    // MARK: - Private methods

    private func setupUI() {
        vkAPIService.getGroup()
        loadData()
    }

    private func loadData() {
        guard let groups = RealmService.get(ItemGroup.self) else { return }
        addGroupNotificationToken(result: groups)
        searchedGroups = groups
    }

    private func addGroupNotificationToken(result: Results<ItemGroup>) {
        groupToken = result.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                break
            case .update:
                self.searchedGroups = result
                self.tableView.reloadData()
            case let .error(error):
                fatalError("\(error)")
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension GroupTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifiers.addGroupSegueId,
            for: indexPath
        ) as? GroupTableViewCell,
            let group = searchedGroups?[indexPath.row]
        else { return UITableViewCell() }
        cell.configureGroup(group)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
