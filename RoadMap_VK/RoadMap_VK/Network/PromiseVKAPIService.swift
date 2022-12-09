// PromiseVKAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import PromiseKit
import RealmSwift

/// Сетевой сервис с промисом
final class PromiseVKAPIService {
    // MARK: - Private Constants

    private enum Constants {
        static let tokenText = "access_token"
        static let fieldsText = "fields"
        static let fieldsValue = "photo_100"
        static let versionText = "v"
        static let versionValue = "5.131"
        static let baseUrl = "https://api.vk.com/method/"
        static let friends = "friends.get?"
    }

    /// Tип запросa
    enum RequestType {
        case friends

        var urlString: String {
            switch self {
            case .friends:
                return "\(Constants.friends)"
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
            }
        }
    }

    // MARK: - Private properties

    private let session = Session.shared
    private let parseGroupDataOperation = ParseGroupDataOperation()
    private let reloadTableViewControllerOperation = SaveRealmOperation()

    // MARK: - Public methods

    func fetchFriends(_ method: RequestType) -> Promise<[FriendsItem]> {
        let methodParameters = method.parameters
        let url = "\(Constants.baseUrl)\(method.urlString)"
        let promise = Promise<[FriendsItem]> { resolver in
            AF.request(url, parameters: methodParameters).responseData { response in
                guard let data = response.data else { return }
                do {
                    let request = try JSONDecoder().decode(VKResponse<FriendsItem>.self, from: data)
                    resolver.fulfill(request.items)
                } catch {
                    resolver.reject(error)
                }
            }
        }
        return promise
    }
}
