//
//  UITextField+Extension.swift
//  RoadMap_VK
//

import UIKit

/// Расширение для установки отступов в текст филдах
extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
}
