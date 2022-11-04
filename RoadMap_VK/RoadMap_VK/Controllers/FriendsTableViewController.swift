// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран друзей
final class FriendsTableViewController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        enum FriendsNames {
            static let joeName = "Joe"
            static let chendlerName = "Chendler"
            static let monicaName = "Monica"
            static let phibieName = "Phibie"
            static let rachelName = "Rachel"
            static let rossName = "Ross"
        }

        enum FriendsImageNames {
            static let joeImageName = "Joe"
            static let chendlerImageName = "Chendler"
            static let monicaImageName = "Monica"
            static let phibieImageName = "Phibie"
            static let rachelImageName = "Rachel"
            static let rossImageName = "Ross"
        }

        enum Identifiers {
            static let friendsIdentifier = "friendsCell"
            static let friendSegue = "friendSegue"
        }
    }

    // MARK: - Private properties

    private var friends: [User] = [
        User(
            name: Constants.FriendsNames.joeName,
            friendPhotoImageName: Constants.FriendsImageNames.joeImageName
        ),
        User(
            name: Constants.FriendsNames.chendlerName,
            friendPhotoImageName: Constants.FriendsImageNames.chendlerImageName
        ),
        User(
            name: Constants.FriendsNames.monicaName,
            friendPhotoImageName: Constants.FriendsImageNames.monicaImageName
        ),
        User(
            name: Constants.FriendsNames.phibieName,
            friendPhotoImageName: Constants.FriendsImageNames.phibieImageName
        ),
        User(
            name: Constants.FriendsNames.rachelName,
            friendPhotoImageName: Constants.FriendsImageNames.rachelImageName
        ),
        User(
            name: Constants.FriendsNames.rossName,
            friendPhotoImageName: Constants.FriendsImageNames.rossImageName
        )
    ]
}

// MARK: - UITableViewDataSource

extension FriendsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifiers.friendsIdentifier,
            for: indexPath
        ) as? FriendsTableViewCell else { return UITableViewCell() }
        cell.refreshPhoto(friends[indexPath.row])
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == Constants.Identifiers.friendSegue,
           let cell = sender as? FriendsTableViewCell,
           let destination = segue
           .destination as?
           FriendPhotosCollectionViewController { destination.friendImageName = cell.friendPhotoImageName }
    }
}
