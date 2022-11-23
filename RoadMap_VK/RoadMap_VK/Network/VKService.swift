// VKService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Сетевой слой
final class VKService {
    // MARK: - Constants

    private enum Constants {
        enum UrlStatements {
            static let baseUrl = "https://api.vk.com"
            static let accessTokenName = "&access_token="
            static let apiKey = Session.shared.token
            static let methodName = "/method"
            static let userIdsName = "?user_ids="
            static let fieldsName = "&fields="
            static let userIds = Session.shared.userId
            static let versionName = "&v="
            static let version = "5.131"
        }

        enum GetFriends {
            static let getFriendsMethod = "/friends.get"
            static let nickname = "nickname"
        }

        enum GetPhotos {
            static let getPhotosMethod = "/photos.getAll"
        }

        enum GetCurrentUserGroups {
            static let getCurrentUserGroupsMethod = "/groups.get?"
            static let extendedName = "&extended="
            static let extendedValue = "1"
        }

        enum GetSearchedGroups {
            static let getCSearchedGroupsMethod = "/groups.search?"
            static let searchedGroupName = "&q="
        }
    }

    // MARK: - Public methods

    func getFriends() {
        let url = Constants.UrlStatements.baseUrl +
            Constants.UrlStatements.methodName +
            Constants.GetFriends.getFriendsMethod +
            Constants.UrlStatements.userIdsName +
            Constants.UrlStatements.userIds +
            Constants.UrlStatements.fieldsName +
            Constants.GetFriends.nickname +
            Constants.UrlStatements.accessTokenName +
            Constants.UrlStatements.apiKey +
            Constants.UrlStatements.versionName +
            Constants.UrlStatements.version
        AF.request(url).responseDecodable { repsonse in
            print(repsonse.value ?? "")
        }
    }

    func getPhotos() {
        let url = Constants.UrlStatements.baseUrl +
            Constants.UrlStatements.methodName +
            Constants.GetPhotos.getPhotosMethod +
            Constants.UrlStatements.userIdsName +
            Constants.UrlStatements.userIds +
            Constants.UrlStatements.accessTokenName +
            Constants.UrlStatements.apiKey +
            Constants.UrlStatements.versionName +
            Constants.UrlStatements.version
        AF.request(url).responseDecodable { repsonse in
            print(repsonse.value ?? "")
        }
    }

    func getCurrentUserGroups() {
        let url = Constants.UrlStatements.baseUrl +
            Constants.UrlStatements.methodName +
            Constants.GetCurrentUserGroups.getCurrentUserGroupsMethod +
            Constants.UrlStatements.userIdsName +
            Constants.UrlStatements.userIds +
            Constants.GetCurrentUserGroups.extendedName +
            Constants.GetCurrentUserGroups.extendedValue +
            Constants.UrlStatements.accessTokenName +
            Constants.UrlStatements.apiKey +
            Constants.UrlStatements.versionName +
            Constants.UrlStatements.version
        AF.request(url).responseDecodable { repsonse in
            print(repsonse.value ?? "")
        }
    }

    func getSearchedGroups(group: String) {
        let url = Constants.UrlStatements.baseUrl +
            Constants.UrlStatements.methodName +
            Constants.GetSearchedGroups.getCSearchedGroupsMethod +
            Constants.UrlStatements.userIdsName +
            Constants.UrlStatements.userIds +
            Constants.GetSearchedGroups.searchedGroupName +
            group +
            Constants.UrlStatements.accessTokenName +
            Constants.UrlStatements.apiKey +
            Constants.UrlStatements.versionName +
            Constants.UrlStatements.version
        AF.request(url).responseDecodable { repsonse in
            print(repsonse.value ?? "")
        }
    }
}
