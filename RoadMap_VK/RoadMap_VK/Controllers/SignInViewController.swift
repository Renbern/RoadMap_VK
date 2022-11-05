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

    // MARK: - IBOutlets

    @IBOutlet private var scrollView: UIScrollView!

    @IBOutlet private var loginTextField: UITextField!

    @IBOutlet private var passwordTextField: UITextField!

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

    @objc private func keyboardWillShownAction(notification: Notification) {
        let info = notification.userInfo as? NSDictionary
        let kbSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size

        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize?.height ?? 0.0, right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }

    @objc private func keyboardWillHideAction(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc private func hideKeyboardAction() {
        scrollView.endEditing(true)
    }

    private func setupUI() {
        configurateKeyboardNotificationCenter()
        configurateLeftPadding()
    }

    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        scrollView.addGestureRecognizer(tapGesture)
    }

    private func configurateKeyboardNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShownAction(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideAction(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        setupTapGestureRecognizer()
    }

    private func removeKeyboardNotificationCenter() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func checkLoginInfo() -> Bool {
        guard let loginText = loginTextField.text,
              let passwordText = passwordTextField.text,
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
        loginTextField.setLeftPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
    }
}
