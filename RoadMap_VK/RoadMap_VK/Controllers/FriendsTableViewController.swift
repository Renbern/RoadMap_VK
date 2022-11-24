// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Экран друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        enum Identifiers {
            static let friendsIdentifier = "friendsCell"
            static let friendSegueID = "friendSegue"
            static let photoSegueID = "photoSegue"
        }
    }

    // MARK: - Private properties

    private lazy var service = VKService()

    private var propertyAnimator: UIViewPropertyAnimator?
    private var friends: [FriendsItem] = []

    private var sectionsMap: [Character: [FriendsItem]] = [:]
    private var sectionTitles: [Character] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFriends()
    }

    // MARK: - Public methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == Constants.Identifiers.photoSegueID,
              let cell = sender as? FriendsTableViewCell,
              let indexPath = tableView.indexPathForSelectedRow,
              let destination = segue.destination as? PhotoViewController else { return }
        destination.photoNames = cell.friendPhotosNames
        destination.userId = getOneUser(indexPath: indexPath)?.userId ?? 1
    }

    // MARK: - Private methods

    private func getOneUser(indexPath: IndexPath) -> FriendsItem? {
        let firstChar = sectionsMap.keys.sorted()[indexPath.section]
        guard let users = sectionsMap[firstChar] else { return nil }
        let user = users[indexPath.row]
        return user
    }

    private func fetchFriends() {
        service.sendRequest(urlString: RequestType.friends.urlString) { [weak self] users in
            self?.friends = users
            self?.setupSections()
            self?.tableView.reloadData()
        }
    }

    private func setupSections() {
        for friend in friends {
            guard let firstLetter = friend.firstName.first else { return }
            if sectionsMap[firstLetter] != nil {
                sectionsMap[firstLetter]?.append(friend)
            } else {
                sectionsMap[firstLetter] = [friend]
            }
        }
        sectionTitles = Array(sectionsMap.keys).sorted()
    }
}

// MARK: - UITableViewDataSource

extension FriendsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionsMap[sectionTitles[section]]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifiers.friendsIdentifier,
            for: indexPath
        ) as? FriendsTableViewCell,
            let friend = sectionsMap[sectionTitles[indexPath.section]]?[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.refreshFriends(friend)
        return cell
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles.compactMap { String($0) }
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = UIColor.white
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sectionTitles[section])
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionsMap.count
    }
}
