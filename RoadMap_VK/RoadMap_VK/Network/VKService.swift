// VKService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Сетевой слой
final class VKService {
    // MARK: - Constants

    private enum Constants {
        enum RequestType {
            case friends
            case groups
            case photos(id: Int)
            case searchGroups(searchQuery: String)

            var urlString: String {
                switch self {
                case .friends:
                    return "\(Method.friends)\(VkUrl.acessToken)\(VkUrl.friendsFields)"
                case .groups:
                    return "\(Method.groups)\(VkUrl.userId)\(VkUrl.extended)\(VkUrl.acessToken)"
                case let .photos(id):
                    return "\(Method.photos)\(VkUrl.acessToken)\(VkUrl.extended)&owner_id=\(-id)"
                case let .searchGroups(searchQuery):
                    return "\(Method.groupsSearch)\(VkUrl.acessToken)&q=\(searchQuery)"
                }
            }
        }

        enum GetFriends {
            static let nickname = "nickname"
        }

        enum GetPhotos {}

        enum GetCurrentUserGroups {
            static let extendedName = "&extended="
            static let extendedValue = "1"
        }

        enum GetSearchedGroups {
            static let searchedGroupName = "&q="
        }
    }

    // MARK: - Public methods

    func sendRequest(urlString: String) {
        AF.request("\(VkUrl.baseUrl)\(urlString)\(VkUrl.version)").responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }
}
