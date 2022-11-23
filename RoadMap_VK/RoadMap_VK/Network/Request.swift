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
enum Url {
    static let baseUrl = "https://api.vk.com/method/"
    static let acessToken = "?&access_token=\(Session.shared.token)"
    static let userId = "user_id=\(Session.shared.userId)"
    static let version = "&v=5.131"
    static let friendsFields = "&fields=nickname"
    static let extended = "&extended=1"
}

/// Tипы запросов
enum RequestType {
    case friends
    case groups
    case photos(id: Int)
    case searchGroups(searchQuery: String)

    var urlString: String {
        switch self {
        case .friends:
            return "\(Method.friends)\(Url.acessToken)\(Url.friendsFields)"
        case .groups:
            return "\(Method.groups)\(Url.userId)\(Url.extended)\(Url.acessToken)"
        case let .photos(id):
            return "\(Method.photos)\(Url.acessToken)\(Url.extended)&owner_id=\(-id)"
        case let .searchGroups(searchQuery):
            return "\(Method.groupsSearch)\(Url.acessToken)&q=\(searchQuery)"
        }
    }
}
