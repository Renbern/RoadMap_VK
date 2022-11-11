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

        enum Photos {
            static let goblinPhotoName = "goblin"
            static let ironOnePhotoName = "iron1"
            static let ironTwoPhotoName = "iron2"
            static let ironThreePhotoName = "iron3"
            static let ironFourPhotoName = "iron4"
            static let tonyPhotoName = "tony"
        }

        enum Identifiers {
            static let friendsIdentifier = "friendsCell"
            static let friendSegueID = "friendSegue"
            static let photoSegueID = "photoSegue"
        }
    }

    // MARK: - Private properties

    private var propertyAnimator: UIViewPropertyAnimator?
    private var users: [User] = [
        User(
            name: Constants.FriendsNames.joeName,
            friendPhotoImageName: Constants.FriendsImageNames.joeImageName,
            photoNames: [
                Constants.Photos.ironOnePhotoName,
                Constants.Photos.ironFourPhotoName,
                Constants.Photos.tonyPhotoName
            ]
        ),
        User(
            name: Constants.FriendsNames.chendlerName,
            friendPhotoImageName: Constants.FriendsImageNames.chendlerImageName,
            photoNames: [
                Constants.Photos.ironTwoPhotoName,
                Constants.Photos.ironThreePhotoName,
                Constants.Photos.goblinPhotoName
            ]
        ),
        User(
            name: Constants.FriendsNames.monicaName,
            friendPhotoImageName: Constants.FriendsImageNames.monicaImageName,
            photoNames: [
                Constants.Photos.ironThreePhotoName,
                Constants.Photos.ironFourPhotoName,
                Constants.Photos.ironOnePhotoName
            ]
        ),
        User(
            name: Constants.FriendsNames.phibieName,
            friendPhotoImageName: Constants.FriendsImageNames.phibieImageName,
            photoNames: [
                Constants.Photos.goblinPhotoName,
                Constants.Photos.ironTwoPhotoName,
                Constants.Photos.ironOnePhotoName
            ]
        ),
        User(
            name: Constants.FriendsNames.rachelName,
            friendPhotoImageName: Constants.FriendsImageNames.rachelImageName,
            photoNames: [
                Constants.Photos.ironThreePhotoName,
                Constants.Photos.ironTwoPhotoName,
                Constants.Photos.tonyPhotoName
            ]
        ),
        User(
            name: Constants.FriendsNames.rossName,
            friendPhotoImageName: Constants.FriendsImageNames.rossImageName,
            photoNames: [
                Constants.Photos.tonyPhotoName,
                Constants.Photos.ironOnePhotoName,
                Constants.Photos.ironThreePhotoName
            ]
        )
    ]

    private var sectionsMap: [Character: [User]] = [:]
    private var sectionTitles: [Character] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSections()
    }

    // MARK: - Public methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == Constants.Identifiers.photoSegueID,
              let cell = sender as? FriendsTableViewCell,
              let destination = segue.destination as? PhotoViewController else { return }
        destination.photoNames = cell.friendPhotosNames
    }

    // MARK: - Private methods

    private func setupSections() {
        for friend in users {
            guard let firstLetter = friend.name.first else { return }
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
        cell.refreshPhoto(friend)
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
