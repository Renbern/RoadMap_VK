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
            static let goblinPhoto = "goblin"
            static let iron1Photo = "iron1"
            static let iron2Photo = "iron2"
            static let iron3Photo = "iron3"
            static let iron4Photo = "iron4"
            static let tonyPhoto = "tony"
        }

        enum Identifiers {
            static let friendsIdentifier = "friendsCell"
            static let friendSegue = "friendSegue"
            static let photoSegue = "photoSegue"
        }
    }

    // MARK: - Private properties

    private var animator: UIViewPropertyAnimator?
    private var friends: [User] = [
        User(
            name: Constants.FriendsNames.joeName,
            friendPhotoImageName: Constants.FriendsImageNames.joeImageName,
            photos: [Constants.Photos.iron1Photo, Constants.Photos.iron4Photo, Constants.Photos.tonyPhoto]
        ),
        User(
            name: Constants.FriendsNames.chendlerName,
            friendPhotoImageName: Constants.FriendsImageNames.chendlerImageName,
            photos: [Constants.Photos.iron2Photo, Constants.Photos.iron3Photo, Constants.Photos.goblinPhoto]
        ),
        User(
            name: Constants.FriendsNames.monicaName,
            friendPhotoImageName: Constants.FriendsImageNames.monicaImageName,
            photos: [Constants.Photos.iron3Photo, Constants.Photos.iron4Photo, Constants.Photos.iron1Photo]
        ),
        User(
            name: Constants.FriendsNames.phibieName,
            friendPhotoImageName: Constants.FriendsImageNames.phibieImageName,
            photos: [Constants.Photos.goblinPhoto, Constants.Photos.iron2Photo, Constants.Photos.iron1Photo]
        ),
        User(
            name: Constants.FriendsNames.rachelName,
            friendPhotoImageName: Constants.FriendsImageNames.rachelImageName,
            photos: [Constants.Photos.iron3Photo, Constants.Photos.iron2Photo, Constants.Photos.tonyPhoto]
        ),
        User(
            name: Constants.FriendsNames.rossName,
            friendPhotoImageName: Constants.FriendsImageNames.rossImageName,
            photos: [Constants.Photos.tonyPhoto, Constants.Photos.iron1Photo, Constants.Photos.iron3Photo]
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
        guard segue.identifier == Constants.Identifiers.photoSegue,
              let cell = sender as? FriendsTableViewCell,
              let destination = segue.destination as? PhotoViewController else { return }
        destination.photoNames = cell.friendPhotos
    }

    // MARK: - Private methods

    private func setupSections() {
        for friend in friends {
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
