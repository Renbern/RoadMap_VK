// UIViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let okActionText = "Ok"
    }

    // MARK: - Public method

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertControllerAction = UIAlertAction(title: Constants.okActionText, style: .default)
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }
}
