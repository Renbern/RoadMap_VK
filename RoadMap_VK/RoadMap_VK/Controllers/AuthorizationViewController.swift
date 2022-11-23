// AuthorizationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Экран первой авторизации
final class AuthorizationViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let urlScheme = "https"
        static let urlHost = "oauth.vk.com"
        static let urlPath = "/authorize"
        static let urlHtmlPath = "/blank.html"
        static let mainStoryboard = "Main"
        static let signInViewControllerName = "SignInViewController"
        static let ampersandSign = "&"
        static let equalsSign = "="

        enum QueryItems {
            static let clientIdName = "client_id"
            static let clientIdValue = "51484005"
            static let displayName = "display"
            static let displayValue = "mobile"
            static let redirectUriName = "redirect_uri"
            static let redirectUriValue = "https://oauth.vk.com/blank.html"
            static let scopeName = "scope"
            static let scopeValue = "262150"
            static let responceTypeName = "response_type"
            static let responceTypeValue = "token"
            static let versionName = "v"
            static let versionValue = "5.68"
        }

        enum Params {
            static let accessTokenName = "access_token"
            static let userId = "user_id"
        }
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    // MARK: - Private properties

    private let vkService = VKService()
    private var urlComponents = URLComponents()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadComponents()
    }

    // MARK: - Private methods

    private func loadComponents() {
        urlComponents.scheme = Constants.urlScheme
        urlComponents.host = Constants.urlHost
        urlComponents.path = Constants.urlPath
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.QueryItems.clientIdName, value: Constants.QueryItems.clientIdValue),
            URLQueryItem(name: Constants.QueryItems.displayName, value: Constants.QueryItems.displayValue),
            URLQueryItem(name: Constants.QueryItems.redirectUriName, value: Constants.QueryItems.redirectUriValue),
            URLQueryItem(name: Constants.QueryItems.scopeName, value: Constants.QueryItems.scopeValue),
            URLQueryItem(name: Constants.QueryItems.responceTypeName, value: Constants.QueryItems.responceTypeValue),
            URLQueryItem(name: Constants.QueryItems.versionName, value: Constants.QueryItems.versionValue)
        ]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: - WKNavigationDelegate

extension AuthorizationViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse:
        WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url,
              url.path == Constants.urlHtmlPath,
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: Constants.ampersandSign)
            .map { $0.components(separatedBy: Constants.equalsSign) }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard
            let token = params[Constants.Params.accessTokenName],
            let userId = params[Constants.Params.userId]
        else {
            return
        }
        Session.shared.token = token
        Session.shared.userId = userId
        decisionHandler(.cancel)
        let storyBoard = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
        guard let vc = storyBoard
            .instantiateViewController(withIdentifier: Constants.signInViewControllerName) as? SignInViewController
        else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
