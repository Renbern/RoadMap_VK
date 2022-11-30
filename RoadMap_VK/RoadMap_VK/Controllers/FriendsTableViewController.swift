// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import RealmSwift
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

    private let vkAPIService = VKAPIService()
    private var friendToken: NotificationToken?

    private var propertyAnimator: UIViewPropertyAnimator?
    private var friends: Results<FriendsItem>?

    private var frendsMap: [Character: [FriendsItem]] = [:]
    private var sectionCharacter: [Character] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Public methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == Constants.Identifiers.photoSegueID,
              let cell = sender as? FriendsTableViewCell,
              let indexPath = tableView.indexPathForSelectedRow,
              let destination = segue.destination as? PhotoViewController else { return }
        destination.photos = cell.photos
        destination.userId = getOneUser(indexPath: indexPath)?.userId ?? 1
    }

    // MARK: - Private methods

    private func getOneUser(indexPath: IndexPath) -> FriendsItem? {
        let firstChar = frendsMap.keys.sorted()[indexPath.section]
        guard let users = frendsMap[firstChar] else { return nil }
        let user = users[indexPath.row]
        return user
    }

    private func fetchFriends() {
        vkAPIService.fetchFriends { result in
            switch result {
            case let .success(friends):
                RealmService.save(items: friends)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func setupSections() {
        guard let friends = friends else { return }
        for friend in friends {
            guard let firstLetter = friend.firstName.first else { return }
            if frendsMap[firstLetter] != nil {
                frendsMap[firstLetter]?.append(friend)
            } else {
                frendsMap[firstLetter] = [friend]
            }
        }
        sectionCharacter = Array(frendsMap.keys).sorted()
    }

    private func loadData() {
        guard let friends = RealmService.get(FriendsItem.self) else { return }
        addFriendNotificationToken(result: friends)
        if !friends.isEmpty {
            self.friends = friends
            setupSections()
        } else {
            fetchFriends()
        }
    }

    private func addFriendNotificationToken(result: Results<FriendsItem>) {
        friendToken = result.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                break
            case .update:
                self.friends = result
                self.setupSections()
                self.tableView.reloadData()
            case let .error(error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension FriendsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        frendsMap[sectionCharacter[section]]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifiers.friendsIdentifier,
            for: indexPath
        ) as? FriendsTableViewCell,
            let friend = frendsMap[sectionCharacter[indexPath.section]]?[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.configure(friend)
        return cell
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionCharacter.compactMap { String($0) }
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = UIColor.white
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sectionCharacter[section])
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        frendsMap.count
    }
}
