// SignInViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран входа в приложение
final class SignInViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let segueIdentifier = "signInSegue"

        enum AdminProfile {
            static let username = "admin"
            static let password = "123"
        }

        enum SignInResult {
            static let success = "Success"
            static let fail = "Fail"
        }

        enum ErrorText {
            static let errorTitle = "Ошибка!"
            static let errorText = "Неправильный логин или пароль"
        }
    }

    // MARK: - Private properties

    private lazy var contentView = self.view as? SignInView

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotificationCenter()
    }

    // MARK: - Public methods

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == Constants.segueIdentifier,
              checkLoginInfo()
        else {
            showLoginErrorAlertController()
            return false
        }
        return true
    }

    // MARK: - Private methods

    private func setupUI() {
        configurateKeyboardNotificationCenter()
        configurateLeftPadding()
    }

    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(contentView?.hideKeyboardAction)
        )
        contentView?.scrollView.addGestureRecognizer(tapGesture)
    }

    private func configurateKeyboardNotificationCenter() {
        contentView?.addKeyboardObserver()
        setupTapGestureRecognizer()
    }

    private func removeKeyboardNotificationCenter() {
        contentView?.removeKeyboardObserver()
    }

    private func checkLoginInfo() -> Bool {
        guard let loginText = contentView?.loginTextField.text,
              let passwordText = contentView?.passwordTextField.text,
              loginText == Constants.AdminProfile.username,
              passwordText == Constants.AdminProfile.password
        else {
            return false
        }
        return true
    }

    private func showLoginErrorAlertController() {
        showAlert(title: Constants.ErrorText.errorTitle, message: Constants.ErrorText.errorText)
    }

    private func configurateLeftPadding() {
        contentView?.loginTextField.setLeftPaddingPoints(10)
        contentView?.passwordTextField.setLeftPaddingPoints(10)
    }
}
