// VKService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Сетевой слой
final class VKService {
    // MARK: - Private Constants

    private enum Constants {
        static let tokenText = "access_token"
        static let fieldsText = "fields"
        static let fieldsValue = "photo_100"
        static let versionText = "v"
        static let versionValue = "5.131"
        static let extendedText = "extended"
        static let extendedValue = "1"
        static let queryText = "q"
        static let ownerIdText = "owner_id"
    }

    // MARK: - Public methods

    func sendRequest(urlString: String, completion: @escaping ([FriendsItem]) -> Void) {
        let url = VkUrl.baseUrl + RequestType.friends.urlString
        let friendRequestParameters: Parameters = [
            Constants.tokenText: Session.shared.token,
            Constants.fieldsText: Constants.fieldsValue,
            Constants.versionText: Constants.versionValue
        ]
        AF.request(url, parameters: friendRequestParameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let items = try JSONDecoder().decode(FriendResponse.self, from: data)
                completion(items.response.friends)
            } catch {
                print(error)
                completion([])
            }
        }
    }

    func sendGroupRequest(urlString: String, completion: @escaping ([ItemGroup]) -> Void) {
        let url = VkUrl.baseUrl + RequestType.groups.urlString
        let groupRequestParameters: Parameters = [
            Constants.tokenText: Session.shared.token,
            Constants.extendedText: Constants.extendedValue,
            Constants.versionText: Constants.versionValue
        ]
        AF.request(url, parameters: groupRequestParameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let items = try JSONDecoder().decode(Group.self, from: data)
                completion(items.response.groups)
            } catch {
                print(error)
                completion([])
            }
        }
    }

    func sendSearchGroupRequest(urlString: String, completion: @escaping ([ItemGroup]) -> Void) {
        let url = VkUrl.baseUrl + RequestType.searchGroups.urlString
        let searchedGroupRequestParameters: Parameters = [
            Constants.queryText: urlString,
            Constants.versionText: Constants.versionValue
        ]
        AF.request(url, parameters: searchedGroupRequestParameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let items = try JSONDecoder().decode(Group.self, from: data)
                completion(items.response.groups)
            } catch {
                print(error)
                completion([])
            }
        }
    }

    func sendPhotoRequest(urlString: String, completion: @escaping (UserPhoto) -> Void) {
        let url = VkUrl.baseUrl + RequestType.photos.urlString
        let friendPhotoRequestParameters: Parameters = [
            Constants.ownerIdText: urlString,
            Constants.versionText: Constants.versionValue
        ]
        AF.request(url, parameters: friendPhotoRequestParameters).responseData { response in
            print(url)
            guard let data = response.value else { return }
            do {
                let users = try JSONDecoder().decode(UserPhoto.self, from: data)
                completion(users)
            } catch {
                print(error)
            }
        }
    }
}
