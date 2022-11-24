// Request.swift
// Copyright © RoadMap. All rights reserved.

/// Типы пути запросов
enum Method {
    static let friends = "friends.get?"
    static let groups = "groups.get?"
    static let photos = "photos.getAll"
    static let groupsSearch = "groups.search?"
}

/// Составные части URL
enum VkUrl {
    static let baseUrl = "https://api.vk.com/method/"
    static let acessToken = "?&access_token=\(Session.shared.token)"
    static let userId = "user_id=\(Session.shared.userId)"
    static let version = "&v=5.131"
    static let friendsFields = "&fields=photo_100"
    static let extended = "&extended=1"
}

/// Tипы запросов
enum RequestType {
    case friends
    case groups
    case photos
    case searchGroups

    var urlString: String {
        switch self {
        case .friends:
//            return "\(Method.friends)\(VkUrl.acessToken)\(VkUrl.friendsFields)"
            return "\(Method.friends)"
        case .groups:
            return "\(Method.groups)\(VkUrl.userId)\(VkUrl.extended)\(VkUrl.acessToken)"
        case let .photos:
            return "\(Method.photos)\(VkUrl.acessToken)"
        case .searchGroups:
            return "\(Method.groupsSearch)\(VkUrl.acessToken)"
        }
    }
}
