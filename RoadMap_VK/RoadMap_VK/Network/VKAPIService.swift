// VKAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import RealmSwift

/// Сетевой слой
final class VKAPIService {
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
        static let filtersText = "filters"
        static let filters = "post"
    }

    /// Типы пути запросов
    enum Method {
        static let friends = "friends.get?"
        static let groups = "groups.get?"
        static let photos = "photos.getAll?"
        static let groupsSearch = "groups.search?"
        static let news = "newsfeed.get?"
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
        case photos(id: Int)
        case searchGroups(query: String)
        case news

        var urlString: String {
            switch self {
            case .friends:
                return "\(Method.friends)"
            case .groups:
                return "\(Method.groups)"
            case .photos:
                return "\(Method.photos)"
            case .searchGroups:
                return "\(Method.groupsSearch)"
            case .news:
                return "\(Method.news)"
            }
        }

        var parameters: Parameters {
            switch self {
            case .friends:
                return [
                    Constants.tokenText: Session.shared.token,
                    Constants.fieldsText: Constants.fieldsValue,
                    Constants.versionText: Constants.versionValue
                ]
            case let .photos(id):
                return [
                    Constants.tokenText: Session.shared.token,
                    Constants.extendedText: Constants.extendedValue,
                    Constants.ownerIdText: id,
                    Constants.versionText: Constants.versionValue
                ]
            case .groups:
                return [
                    Constants.tokenText: Session.shared.token,
                    Constants.extendedText: Constants.extendedValue,
                    Constants.versionText: Constants.versionValue
                ]
            case let .searchGroups(query):
                return [
                    Constants.tokenText: Session.shared.token,
                    Constants.queryText: query,
                    Constants.versionText: Constants.versionValue
                ]
            case .news:
                return [
                    Constants.tokenText: Session.shared.token,
                    Constants.filtersText: Constants.filters,
                    Constants.versionText: Constants.versionValue
                ]
            }
        }
    }

    // MARK: - Private properties

    private let decoder = JSONDecoder()
    private let session = Session.shared

    // MARK: - Public methods

    func fetchNews(completion: @escaping (Result<PostResponse, Error>) -> Void) {
        request(.news) { [weak self] data in
            guard
                let self = self,
                let data = data,
                let response = try? self.decoder.decode(News.self, from: data)
            else {
                return
            }
            completion(.success(response.response))
        }
    }

    func fetchFriends(completion: @escaping (Result<[FriendsItem], Error>) -> Void) {
        request(.friends) { [weak self] data in
            guard
                let self = self,
                let data = data,
                let response = try? self.decoder.decode(VKResponse<FriendsItem>.self, from: data)
            else {
                return
            }
            completion(.success(response.items))
        }
    }

    func fetchGroups(completion: @escaping (Result<[ItemGroup], Error>) -> Void) {
        request(.groups) { [weak self] data in
            guard
                let self = self,
                let data = data,
                let response = try? self.decoder.decode(VKResponse<ItemGroup>.self, from: data)
            else {
                return
            }
            completion(.success(response.items))
        }
    }

    func fetchGroups(searchQuery: String, completion: @escaping (Result<[ItemGroup], Error>) -> Void) {
        request(.searchGroups(query: searchQuery)) { [weak self] data in
            guard
                let self = self,
                let data = data,
                let response = try? self.decoder.decode(VKResponse<ItemGroup>.self, from: data)
            else {
                return
            }
            completion(.success(response.items))
        }
    }

    func fetchPhotos(for userId: Int, completion: @escaping (Result<[PhotoUrlPaths], Error>) -> Void) {
        request(.photos(id: userId)) { [weak self] data in
            guard
                let self = self,
                let data = data,
                let result = try? self.decoder.decode(VKResponse<PhotoUrlPaths>.self, from: data)
            else {
                return
            }
            completion(.success(result.items))
        }
    }

    func getGroup() {
        let operationQueue = OperationQueue()
        let request = getGroupRequest(.groups)
        let getDataOperation = GetDataOperation(request: request)
        operationQueue.addOperation(getDataOperation)
        let parseData = ParseGroupDataOperation()
        parseData.addDependency(getDataOperation)
        operationQueue.addOperation(parseData)
        let saveToRealm = SaveRealmOperation()
        saveToRealm.addDependency(parseData)
        OperationQueue.main.addOperation(saveToRealm)
    }

    // MARK: - Private methods

    private func request(_ method: RequestType, completion: @escaping (Data?) -> Void) {
        let methodParameters = method.parameters
        let url = "\(VkUrl.baseUrl)\(method.urlString)"
        AF.request(url, parameters: methodParameters).responseData { response in
            guard let data = response.data else { return }
            completion(data)
        }
    }

    private func getGroupRequest(_ method: RequestType) -> DataRequest {
        let methodParameters = method.parameters
        let url = "\(VkUrl.baseUrl)\(method.urlString)"
        let request = AF.request(url, parameters: methodParameters)
        return request
    }
}

/// Расширение для получения фото
extension UIImageView {
    func load(url: String?) {
        let photoCacheService = PhotoCacheService()
        guard let url = url else { return }
        DispatchQueue.global().async {
            let image = photoCacheService.photo(byUrl: url)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
